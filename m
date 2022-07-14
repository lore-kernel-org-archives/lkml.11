Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 216BFCCA480
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jul 2022 09:57:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234772AbiGNJ5O (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jul 2022 05:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbiGNJ5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 05:57:07 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D804A4C609;
        Thu, 14 Jul 2022 02:57:06 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1oBvaj-0006rx-03; Thu, 14 Jul 2022 11:57:05 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 517A0C0493; Thu, 14 Jul 2022 11:56:03 +0200 (CEST)
Date:   Thu, 14 Jul 2022 11:56:03 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rahul Bedarkar <rahulbedarkar89@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 2/2] MIPS: dts: align gpio-key node names with dtschema
Message-ID: <20220714095603.GD10086@alpha.franken.de>
References: <20220624170740.66271-1-krzysztof.kozlowski@linaro.org>
 <20220624170740.66271-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220624170740.66271-2-krzysztof.kozlowski@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 24, 2022 at 07:07:40PM +0200, Krzysztof Kozlowski wrote:
> The node names should be generic and DT schema expects certain pattern
> (e.g. with key/button/switch).
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  arch/mips/boot/dts/ingenic/ci20.dts                        | 2 +-
>  arch/mips/boot/dts/ralink/gardena_smart_gateway_mt7688.dts | 2 +-
>  arch/mips/boot/dts/ralink/mt7621-gnubee-gb-pc1.dts         | 2 +-
>  arch/mips/boot/dts/ralink/mt7621-gnubee-gb-pc2.dts         | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
