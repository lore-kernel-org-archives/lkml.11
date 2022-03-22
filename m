Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E52F9C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Mar 2022 22:57:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238595AbiCVW6l (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Mar 2022 18:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232036AbiCVW6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 18:58:40 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7389A5E15D
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 15:57:07 -0700 (PDT)
X-UUID: 929a4578d44d469d9c90fe63c57af886-20220323
X-UUID: 929a4578d44d469d9c90fe63c57af886-20220323
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1296627398; Wed, 23 Mar 2022 06:57:02 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Wed, 23 Mar 2022 06:57:00 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 23 Mar 2022 06:57:00 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     <liaoyu15@huawei.com>
CC:     <linux-kernel@vger.kernel.org>, <liwei391@huawei.com>,
        <marcel@holtmann.org>, <yake.yang@mediatek.com>
Subject: Re: [PATCH] Bluetooth: mt7921s: Fix a wrong judgment in btmtksdio_get_codec_config_data()
Date:   Wed, 23 Mar 2022 06:57:00 +0800
Message-ID: <20220322225700.16125-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220322023630.1239271-1-liaoyu15@huawei.com>
References: <20220322023630.1239271-1-liaoyu15@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yu,

>Since ven_data is a double pointer, it should be *ven_data here.
>
>Fixes: f41b91fa1783 ("Bluetooth: mt7921s: Add .btmtk_get_codec_config_data")
>Signed-off-by: Yu Liao <liaoyu15@huawei.com>
>---
> drivers/bluetooth/btmtksdio.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.c
>index f3dc5881fff7..b6d77e04240c 100644
>--- a/drivers/bluetooth/btmtksdio.c
>+++ b/drivers/bluetooth/btmtksdio.c
>@@ -961,7 +961,7 @@ static int btmtksdio_get_codec_config_data(struct hci_dev *hdev,
> 	}
> 
> 	*ven_data = kmalloc(sizeof(__u8), GFP_KERNEL);
>-	if (!ven_data) {
>+	if (!*ven_data) {
> 		err = -ENOMEM;
> 		goto error;
> 	}

Thanks for fixing this.

Reviewed-by: Miles Chen <miles.chen@mediatek.com>
