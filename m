Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88C7EC19F2A
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Aug 2022 15:41:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236265AbiHKPlx (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Aug 2022 11:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236302AbiHKPkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 11:40:36 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6A26832EE;
        Thu, 11 Aug 2022 08:36:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 0C259CE223C;
        Thu, 11 Aug 2022 15:36:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92B76C433D6;
        Thu, 11 Aug 2022 15:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660232171;
        bh=qsShld15yanExGZz6tj+YI1xZMgoDwaENHBqd2mx4bU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cNcphdIWAXT6nB9wNAJsYoUHgHVt1MefuabHLfxkfhrw/sFEl4ZLBaKY3AoFZ03Re
         jNOjUzJGanUK4FD7+xgNU7zXYAQcih+CgovFXqFDiG96GLShQsreEKnS0z/cFwRih2
         dHV0CCwxy+pVLUuBkysoKi5RkgucPD4GQ89qcyUkFLe0umlmLExUGaqOcjAfE4F1/Y
         zZls0lo6AL1C6K0RUBpjUgrBRNjGmkJkkvskq1QYpf3vW2dJxmcei55uFLEY3X/xF9
         3JJ+8jvddfuPipdM90NjxQpUbuepAQn6GfaZl2anEE9drFZTYrj6Bjrdw9+qa5NEuF
         fRM8/nJXYXuGg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Sasha Levin <sashal@kernel.org>, linux-doc@vger.kernel.org
Subject: [PATCH AUTOSEL 5.19 063/105] scripts: sphinx-pre-install: fix venv version check logic
Date:   Thu, 11 Aug 2022 11:27:47 -0400
Message-Id: <20220811152851.1520029-63-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220811152851.1520029-1-sashal@kernel.org>
References: <20220811152851.1520029-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mauro Carvalho Chehab <mchehab@kernel.org>

[ Upstream commit 7c2d45a347c7933cbe0efff14fe96adeb13fd761 ]

The logic which checks if the venv version is good enough
but was not activated is broken: it is checking against
the wrong val, making it to recommend to re-create a venv
every time. Fix it.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Link: https://lore.kernel.org/r/afe01b7863fd655986d84ace8948f3d7aede796d.1656756450.git.mchehab@kernel.org
Signed-off-by: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 scripts/sphinx-pre-install | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/scripts/sphinx-pre-install b/scripts/sphinx-pre-install
index f126ecbb0494..ae8c49734899 100755
--- a/scripts/sphinx-pre-install
+++ b/scripts/sphinx-pre-install
@@ -741,7 +741,7 @@ sub recommend_sphinx_upgrade()
 
 	# Get the highest version from sphinx_*/bin/sphinx-build and the
 	# corresponding command to activate the venv/virtenv
-	$activate_cmd = get_virtenv();
+	($activate_cmd, $venv_ver) = get_virtenv();
 
 	# Store the highest version from Sphinx existing virtualenvs
 	if (($activate_cmd ne "") && ($venv_ver gt $cur_version)) {
@@ -759,10 +759,14 @@ sub recommend_sphinx_upgrade()
 	# Either there are already a virtual env or a new one should be created
 	$need_pip = 1;
 
+	return if (!$latest_avail_ver);
+
 	# Return if the reason is due to an upgrade or not
 	if ($latest_avail_ver lt $rec_version) {
 		$rec_sphinx_upgrade = 1;
 	}
+
+	return $latest_avail_ver;
 }
 
 #
@@ -820,7 +824,7 @@ sub recommend_sphinx_version($)
 	}
 
 	# Suggest newer versions if current ones are too old
-	if ($latest_avail_ver && $cur_version ge $min_version) {
+	if ($latest_avail_ver && $latest_avail_ver ge $min_version) {
 		# If there's a good enough version, ask the user to enable it
 		if ($latest_avail_ver ge $rec_version) {
 			printf "\nNeed to activate Sphinx (version $latest_avail_ver) on virtualenv with:\n";
@@ -897,7 +901,7 @@ sub check_needs()
 		}
 	}
 
-	recommend_sphinx_upgrade();
+	my $venv_ver = recommend_sphinx_upgrade();
 
 	my $virtualenv_cmd;
 
-- 
2.35.1

