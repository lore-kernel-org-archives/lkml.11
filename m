Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 832FDC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Feb 2022 09:59:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237180AbiBWJ73 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Feb 2022 04:59:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231278AbiBWJ71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 04:59:27 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 150B93F8BF;
        Wed, 23 Feb 2022 01:58:58 -0800 (PST)
X-UUID: b71f42d1d9fd470794ced5a621dc1fc7-20220223
X-UUID: b71f42d1d9fd470794ced5a621dc1fc7-20220223
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <johnson.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 937428488; Wed, 23 Feb 2022 17:58:55 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Wed, 23 Feb 2022 17:58:53 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 23 Feb
 2022 17:58:53 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 23 Feb 2022 17:58:53 +0800
Message-ID: <d12511c6d1ae317b317229fc78df818840153853.camel@mediatek.com>
Subject: Re: [PATCH 2/4] regulator: mt6366: Add support for MT6366 regulator
From:   Johnson Wang <johnson.wang@mediatek.com>
To:     Mark Brown <broonie@kernel.org>
CC:     <lee.jones@linaro.org>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Wed, 23 Feb 2022 17:58:53 +0800
In-Reply-To: <Ydbno0JM8YP9NhNh@sirena.org.uk>
References: <20220106065407.16036-1-johnson.wang@mediatek.com>
         <20220106065407.16036-3-johnson.wang@mediatek.com>
         <Ydbno0JM8YP9NhNh@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-01-06 at 12:59 +0000, Mark Brown wrote:
> On Thu, Jan 06, 2022 at 02:54:05PM +0800, Johnson Wang wrote:
> > The MT6366 is a regulator found on boards based on MediaTek MT8186
> > and
> > probably other SoCs. It is a so called pmic and connects as a slave
> > to
> > SoC using SPI, wrapped inside the pmic-wrapper.
> 
> Reviwed-by: Mark Brown <broonie@kernel.org>

Hi Mark,

Thank you for review.

Do these regulator patches need some improvement?
If yes, please give me your advices.

Otherwise, is it possible to apply these patches in the future?

Thanks.

BRs,
Johnson Wang 

