Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 498C1C433FE
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Mar 2022 07:27:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242218AbiCWH3T (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Mar 2022 03:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233037AbiCWH3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 03:29:17 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBF2E7307F;
        Wed, 23 Mar 2022 00:27:46 -0700 (PDT)
X-UUID: e15f1e9d55d14d03bebaae2c8d269a2a-20220323
X-UUID: e15f1e9d55d14d03bebaae2c8d269a2a-20220323
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1533571860; Wed, 23 Mar 2022 15:27:40 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Wed, 23 Mar 2022 15:27:39 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 23 Mar
 2022 15:27:39 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 23 Mar 2022 15:27:38 +0800
Message-ID: <f7fa502776ce2d28553238fb10289f07de0a1d77.camel@mediatek.com>
Subject: Re: [PATCH v3 3/6] ASoC: dt-bindings: mediatek: mt8195: merge
 mt8195 machine yaml
From:   Trevor Wu <trevor.wu@mediatek.com>
To:     Miles Chen <miles.chen@mediatek.com>
CC:     <aaronyu@google.com>, <alsa-devel@alsa-project.org>,
        <angelogioacchino.delregno@collabora.com>, <broonie@kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <matthias.bgg@gmail.com>,
        <robh+dt@kernel.org>, <tiwai@suse.com>, <tzungbi@google.com>,
        <yc.hung@mediatek.com>
Date:   Wed, 23 Mar 2022 15:27:39 +0800
In-Reply-To: <20220321233045.22156-1-miles.chen@mediatek.com>
References: <20220321072312.14972-4-trevor.wu@mediatek.com>
         <20220321233045.22156-1-miles.chen@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-03-22 at 07:30 +0800, Miles Chen wrote:
> Hi Trevor,
> 
> >  
> > -title: Mediatek MT8195 with MT6359, RT1019 and RT5682 ASoC sound
> > card driver
> > +title: Mediatek MT8195 ASoC sound card driver
> 
> s/Mediatek/MediaTek/
> 
> Thanks,
> Miles

OK. I will update it in v4.

Thanks,
Trevor

> >  
> >  maintainers:
> >    - Trevor Wu <trevor.wu@mediatek.com>
> > @@ -14,7 +14,9 @@ description:
> >  
> >  properties:
> >    compatible:
> > -    const: mediatek,mt8195_mt6359_rt1019_rt5682
> > +    enum:
> > +      - mediatek,mt8195_mt6359_rt1019_rt5682
> > +      - mediatek,mt8195_mt6359_rt1011_rt5682
> >  
> >    model:
> >      $ref: /schemas/types.yaml#/definitions/string

