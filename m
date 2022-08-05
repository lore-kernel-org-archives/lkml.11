Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 175B7C25B07
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Aug 2022 09:13:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240417AbiHEJNN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Aug 2022 05:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240152AbiHEJNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 05:13:10 -0400
Received: from unicom145.biz-email.net (unicom145.biz-email.net [210.51.26.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A47A674DDE;
        Fri,  5 Aug 2022 02:13:01 -0700 (PDT)
Received: from ([60.208.111.195])
        by unicom145.biz-email.net ((D)) with ASMTP (SSL) id AJS00156;
        Fri, 05 Aug 2022 17:12:56 +0800
Received: from localhost.localdomain (10.200.104.97) by
 jtjnmail201605.home.langchao.com (10.100.2.5) with Microsoft SMTP Server id
 15.1.2507.9; Fri, 5 Aug 2022 17:12:55 +0800
From:   Bo Liu <liubo03@inspur.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>
CC:     <kvm@vger.kernel.org>, <virtualization@lists.linux-foundation.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bo Liu <liubo03@inspur.com>
Subject: [PATCH] vhost-vdpa: Call ida_simple_remove() when failed
Date:   Fri, 5 Aug 2022 05:12:54 -0400
Message-ID: <20220805091254.20026-1-liubo03@inspur.com>
X-Mailer: git-send-email 2.18.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.200.104.97]
tUid:   20228051712564b68e5e4e530f6396c94bdd65571fa10
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In function vhost_vdpa_probe(), when code execution fails, we should
call ida_simple_remove() to free ida.

Signed-off-by: Bo Liu <liubo03@inspur.com>
---
 drivers/vhost/vdpa.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index 7fa671ac4bdf..c7c89f969249 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -1396,6 +1396,7 @@ static int vhost_vdpa_probe(struct vdpa_device *vdpa)
 
 err:
 	put_device(&v->dev);
+	ida_simple_remove(&vhost_vdpa_ida, v->minor);
 	return r;
 }
 
-- 
2.27.0

