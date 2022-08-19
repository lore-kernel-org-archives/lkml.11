Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91D9BC28B2B
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Aug 2022 16:42:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353686AbiHSQm4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Aug 2022 12:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353448AbiHSQkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 12:40:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3381812420F;
        Fri, 19 Aug 2022 09:08:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E296661825;
        Fri, 19 Aug 2022 16:07:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8679C433C1;
        Fri, 19 Aug 2022 16:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1660925274;
        bh=FSjGEW/rKIhnK/pYE+w8JHxX2GWGcmQAudzXX4aoGf8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MQP8YmD/lRHZawFVdCgjt0YfuW1gh0kzwmDGSxkzYEe90y+ZYTroWaU3EThIiPENP
         tyAL8uO+VlUSb/XncCd4rB9R35FZoLPzMGoLfKINoz/ohevZokxTwkpl5QFblTz1F3
         5lZ2F7VV7UAmTwjumioNSG29M2Ns3ChpZJl1rxFo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xie Yongji <xieyongji@bytedance.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 410/545] fuse: Remove the control interface for virtio-fs
Date:   Fri, 19 Aug 2022 17:43:00 +0200
Message-Id: <20220819153847.769646478@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220819153829.135562864@linuxfoundation.org>
References: <20220819153829.135562864@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xie Yongji <xieyongji@bytedance.com>

[ Upstream commit c64797809a64c73497082aa05e401a062ec1af34 ]

The commit 15c8e72e88e0 ("fuse: allow skipping control interface and forced
unmount") tries to remove the control interface for virtio-fs since it does
not support aborting requests which are being processed. But it doesn't
work now.

This patch fixes it by skipping creating the control interface if
fuse_conn->no_control is set.

Fixes: 15c8e72e88e0 ("fuse: allow skipping control interface and forced unmount")
Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/fuse/control.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/control.c b/fs/fuse/control.c
index cc7e94d73c6c..24b4d9db231d 100644
--- a/fs/fuse/control.c
+++ b/fs/fuse/control.c
@@ -275,7 +275,7 @@ int fuse_ctl_add_conn(struct fuse_conn *fc)
 	struct dentry *parent;
 	char name[32];
 
-	if (!fuse_control_sb)
+	if (!fuse_control_sb || fc->no_control)
 		return 0;
 
 	parent = fuse_control_sb->s_root;
@@ -313,7 +313,7 @@ void fuse_ctl_remove_conn(struct fuse_conn *fc)
 {
 	int i;
 
-	if (!fuse_control_sb)
+	if (!fuse_control_sb || fc->no_control)
 		return;
 
 	for (i = fc->ctl_ndents - 1; i >= 0; i--) {
-- 
2.35.1



