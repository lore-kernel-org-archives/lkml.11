Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D26E1C433EF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jun 2022 17:44:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347552AbiFGRoG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jun 2022 13:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347947AbiFGRbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 13:31:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D42E11CA22;
        Tue,  7 Jun 2022 10:28:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D779BB82285;
        Tue,  7 Jun 2022 17:28:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DA95C34115;
        Tue,  7 Jun 2022 17:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1654622930;
        bh=DtHJIM0o0kZFOpi+gNqdluDzT/TvC0d1gsK1qWbUl+c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lF7ecVSEAgOf80oJkXLHlGAEAtTfqymtGU1PCYq51C9awWda4RVbqwy6zRbOumUIN
         GB8anvEtnwkAbXIK7MjAB3PG1gS/KeLnWH8iE19yHGf3bQegWafapFlEtFMYQM69TG
         vaPY9bPpceYmazS41ZR6Ndd0vyBpFET7j+a9frWQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Biggers <ebiggers@google.com>,
        Ritesh Harjani <ritesh.list@gmail.com>,
        Lukas Czerner <lczerner@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 233/452] ext4: reject the commit option on ext2 filesystems
Date:   Tue,  7 Jun 2022 19:01:30 +0200
Message-Id: <20220607164915.505202877@linuxfoundation.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220607164908.521895282@linuxfoundation.org>
References: <20220607164908.521895282@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

[ Upstream commit cb8435dc8ba33bcafa41cf2aa253794320a3b8df ]

The 'commit' option is only applicable for ext3 and ext4 filesystems,
and has never been accepted by the ext2 filesystem driver, so the ext4
driver shouldn't allow it on ext2 filesystems.

This fixes a failure in xfstest ext4/053.

Fixes: 8dc0aa8cf0f7 ("ext4: check incompatible mount options while mounting ext2/3")
Signed-off-by: Eric Biggers <ebiggers@google.com>
Reviewed-by: Ritesh Harjani <ritesh.list@gmail.com>
Reviewed-by: Lukas Czerner <lczerner@redhat.com>
Link: https://lore.kernel.org/r/20220510183232.172615-1-ebiggers@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/super.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 3e26edeca8c7..35d990adefc6 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1960,6 +1960,7 @@ static const struct mount_opts {
 	 MOPT_EXT4_ONLY | MOPT_CLEAR},
 	{Opt_warn_on_error, EXT4_MOUNT_WARN_ON_ERROR, MOPT_SET},
 	{Opt_nowarn_on_error, EXT4_MOUNT_WARN_ON_ERROR, MOPT_CLEAR},
+	{Opt_commit, 0, MOPT_NO_EXT2},
 	{Opt_nojournal_checksum, EXT4_MOUNT_JOURNAL_CHECKSUM,
 	 MOPT_EXT4_ONLY | MOPT_CLEAR},
 	{Opt_journal_checksum, EXT4_MOUNT_JOURNAL_CHECKSUM,
-- 
2.35.1



