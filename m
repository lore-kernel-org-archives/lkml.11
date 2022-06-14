Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40969C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jun 2022 13:34:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242223AbiFNNet (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jun 2022 09:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243308AbiFNNeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 09:34:44 -0400
Received: from hust.edu.cn (unknown [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE5C41C11F
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 06:34:43 -0700 (PDT)
Received: from localhost.localdomain ([172.16.0.254])
        (user=dzm91@hust.edu.cn mech=LOGIN bits=0)
        by mx1.hust.edu.cn  with ESMTP id 25EDWoU6010890-25EDWoU9010890
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 14 Jun 2022 21:32:54 +0800
From:   Dongliang Mu <dzm91@hust.edu.cn>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Martin Kaiser <martin@kaiser.cx>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>
Cc:     Dongliang Mu <mudongliangabcd@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2] driver: r8188eu: remove NULL check before vfree
Date:   Tue, 14 Jun 2022 21:32:29 +0800
Message-Id: <20220614133239.147076-1-dzm91@hust.edu.cn>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-FEAS-AUTH-USER: dzm91@hust.edu.cn
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dongliang Mu <mudongliangabcd@gmail.com>

vfree can handle NULL pointer as its argument.
According to coccinelle isnullfree check, remove NULL check
before vfree operation.

Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
---
v1->v2: fix the logic change in the patch v1
 drivers/staging/r8188eu/os_dep/usb_intf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/r8188eu/os_dep/usb_intf.c b/drivers/staging/r8188eu/os_dep/usb_intf.c
index 68869c5daeff..cc2b44f60c46 100644
--- a/drivers/staging/r8188eu/os_dep/usb_intf.c
+++ b/drivers/staging/r8188eu/os_dep/usb_intf.c
@@ -372,7 +372,7 @@ static struct adapter *rtw_usb_if1_init(struct dvobj_priv *dvobj,
 free_adapter:
 	if (pnetdev)
 		rtw_free_netdev(pnetdev);
-	else if (padapter)
+	else
 		vfree(padapter);
 
 	return NULL;
-- 
2.35.1

