Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94269C4332F
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Apr 2022 12:19:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383019AbiDEMRr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 08:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244973AbiDEIww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 04:52:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 805451CFFB;
        Tue,  5 Apr 2022 01:48:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1C9A660FFC;
        Tue,  5 Apr 2022 08:48:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31986C385A1;
        Tue,  5 Apr 2022 08:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649148498;
        bh=kTf509aGxUC2L+Qqne7LOHBXyNCvMcSwY5mKQwAKabs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aj9+VWZpxB8NdjuLlKU9mVsGJJ1W6QrX5kmtUW6qV5RZWQrmLNMCbk123Z01jgjvj
         MgZcOaffFJNJjLKM7AP2aVswfS3Fv41MBnRIXRONgJzcsPIt9czNgyPoum6mXYT0ro
         b2/QFgXoA5Ck9bCFp7pyRrRX5KFQYyWCOqWuqlVk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jakob Koschel <jakobkoschel@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.16 0376/1017] media: saa7134: fix incorrect use to determine if list is empty
Date:   Tue,  5 Apr 2022 09:21:29 +0200
Message-Id: <20220405070405.447370620@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220405070354.155796697@linuxfoundation.org>
References: <20220405070354.155796697@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jakob Koschel <jakobkoschel@gmail.com>

[ Upstream commit 9f1f4b642451d35667a4dc6a9c0a89d954b530a3 ]

'dev' will *always* be set by list_for_each_entry().
It is incorrect to assume that the iterator value will be NULL if the
list is empty.

Instead of checking the pointer it should be checked if
the list is empty.

Fixes: 79dd0c69f05f ("V4L: 925: saa7134 alsa is now a standalone module")
Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/pci/saa7134/saa7134-alsa.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/pci/saa7134/saa7134-alsa.c b/drivers/media/pci/saa7134/saa7134-alsa.c
index fb24d2ed3621..d3cde05a6eba 100644
--- a/drivers/media/pci/saa7134/saa7134-alsa.c
+++ b/drivers/media/pci/saa7134/saa7134-alsa.c
@@ -1214,7 +1214,7 @@ static int alsa_device_exit(struct saa7134_dev *dev)
 
 static int saa7134_alsa_init(void)
 {
-	struct saa7134_dev *dev = NULL;
+	struct saa7134_dev *dev;
 
 	saa7134_dmasound_init = alsa_device_init;
 	saa7134_dmasound_exit = alsa_device_exit;
@@ -1229,7 +1229,7 @@ static int saa7134_alsa_init(void)
 			alsa_device_init(dev);
 	}
 
-	if (dev == NULL)
+	if (list_empty(&saa7134_devlist))
 		pr_info("saa7134 ALSA: no saa7134 cards found\n");
 
 	return 0;
-- 
2.34.1



