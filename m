Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B266ECAAA1
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Sep 2022 22:31:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbiIBWbS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Sep 2022 18:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiIBWbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 18:31:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C06AAD8E2B;
        Fri,  2 Sep 2022 15:31:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 75342B82DE6;
        Fri,  2 Sep 2022 22:31:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9F56C433D6;
        Fri,  2 Sep 2022 22:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662157873;
        bh=+3hHBaBf93dmnzMp8U1VFk3F2ls4JhL4RSGcv7sUVGw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tYXlgRDnQllT2fOGTGtM/BV/Vz53aozxerzZIeKqYr8WW/OT4AiHtms623q1X93Z5
         2xy32m4/IulQ6OJwLRjKQCQzTHDKr0acN2k5cK/e4lBtiAaPom+ggXtV46LATD7xOb
         BrlNlR3R7GiR1ydbHT5EmKQZui2HlVU7TMrtHM0VMPl7bkNcOFZh9GxqU9BI1lFUXN
         7KgEhASLK9KsdqQxmZZ53EUDEjOZHQd2Gtd1hSonQMsFEvoS1iKbZqD7k8gtWojxZB
         uXALHPKQdQziy54plvBPmtXVrsNL4+SdXlXsyA7StvtJmIhqBaeHLOSz0zrNe0Cj50
         N5Kbwqd2W8soA==
Received: by pali.im (Postfix)
        id 2557E7EA; Sat,  3 Sep 2022 00:31:10 +0200 (CEST)
Date:   Sat, 3 Sep 2022 00:31:10 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: marvell: Fix compatible strings for Armada
 3720 boards
Message-ID: <20220902223110.ob2uepbjzubdf4d3@pali>
References: <20220713125644.3117-1-pali@kernel.org>
 <20220808202456.lpwvhq22edb56ptf@pali>
 <YvFzGhBRPTXgdCd8@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YvFzGhBRPTXgdCd8@lunn.ch>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 08 August 2022 22:33:30 Andrew Lunn wrote:
> On Mon, Aug 08, 2022 at 10:24:56PM +0200, Pali Rohár wrote:
> > PING?
> 
> It is too late for the merge window.

So, now for the next?

> > > diff --git a/arch/arm64/boot/dts/marvell/armada-372x.dtsi b/arch/arm64/boot/dts/marvell/armada-372x.dtsi
> > > index 5ce55bdbb995..02ae1e153288 100644
> > > --- a/arch/arm64/boot/dts/marvell/armada-372x.dtsi
> > > +++ b/arch/arm64/boot/dts/marvell/armada-372x.dtsi
> > > @@ -13,7 +13,7 @@
> > >  
> > >  / {
> > >  	model = "Marvell Armada 3720 SoC";
> > > -	compatible = "marvell,armada3720", "marvell,armada3710";
> > > +	compatible = "marvell,armada3720", "marvell,armada3700";
> 
> Does it make sense to have a compatible here? The board .dts should
> provide it. And if the board does not provide it, we probably want the
> board to not boot because it does not have a compatible.
> 
>    Andrew
