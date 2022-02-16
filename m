Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E657C433FE
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Feb 2022 05:55:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243906AbiBPFzZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Feb 2022 00:55:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234272AbiBPFzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 00:55:22 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA607C12FB;
        Tue, 15 Feb 2022 21:55:06 -0800 (PST)
X-UUID: c07bc4593c3b447483f06278c4671c7e-20220216
X-UUID: c07bc4593c3b447483f06278c4671c7e-20220216
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 138608058; Wed, 16 Feb 2022 13:55:02 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Wed, 16 Feb 2022 13:55:01 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 16 Feb 2022 13:54:59 +0800
Message-ID: <d9637b40196873f392ac9cebfe369106a6f0eee7.camel@mediatek.com>
Subject: Re: [PATCH v4 08/35] iommu/mediatek: Use kmalloc for protect buffer
From:   Yong Wu <yong.wu@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
CC:     Robin Murphy <robin.murphy@arm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Tomasz Figa <tfiga@chromium.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>, <youlin.pei@mediatek.com>,
        <anan.sun@mediatek.com>, <xueqi.zhang@mediatek.com>,
        <yen-chang.chen@mediatek.com>, <mingyuan.ma@mediatek.com>,
        <yf.wang@mediatek.com>, <libo.kang@mediatek.com>,
        <chengci.xu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        Will Deacon <will@kernel.org>
Date:   Wed, 16 Feb 2022 13:54:59 +0800
In-Reply-To: <ca47becf-adc9-f11e-5e59-03f203920344@collabora.com>
References: <20220125085634.17972-1-yong.wu@mediatek.com>
         <20220125085634.17972-9-yong.wu@mediatek.com>
         <ca47becf-adc9-f11e-5e59-03f203920344@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-01-27 at 12:08 +0100, AngeloGioacchino Del Regno wrote:
> Il 25/01/22 09:56, Yong Wu ha scritto:
> > No need zero for the protect buffer that is only accessed by the
> > IOMMU HW
> > translation fault happened.
> > 
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> 
> I would rather keep this a devm_kzalloc instead... the cost is very
> minimal and
> this will be handy when new hardware will be introduced, as it may
> require a bigger
> buffer: in that case, "older" platforms will use only part of it and
> we may get
> garbage data at the end.

Currently this is to avoid zero 512 bytes for all the platforms.

Sorry, I don't understand why it is unnecessary when the new hardware
requires a bigger buffer. If the buffer becomes bigger, then clearing
it to 0 need more cost. then this patch is more helpful?

The content in this buffer is garbage, we won't care about or analyse
it.

> 
> Regards,
> Angelo

