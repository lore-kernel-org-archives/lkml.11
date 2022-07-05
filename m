Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AB3EC43334
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Jul 2022 01:09:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233550AbiGEBJw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Jul 2022 21:09:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbiGEBJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 21:09:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B510D6478;
        Mon,  4 Jul 2022 18:09:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 403C161800;
        Tue,  5 Jul 2022 01:09:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A12D8C3411E;
        Tue,  5 Jul 2022 01:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656983388;
        bh=eCjEolV3AVedkb/EmSC/BPDJfCgc+yz8X23omCUFso0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iy8Hzx/gk6FHAicQV7GHlpORFrGHaIs2KGcw5roUdmpmnOGtMH/ODAhpCs81XnrS3
         RNDljMYQsELuPD6HI16nHemNq0x7mqkvugxSILXr5PNtzIoWB5TLyzZueM4XSaM/Ju
         yKHhtk/qdjj/nYfqfEQgDu2Kt9vUQ03h4fBQOw4eMIbsXOSnKGlER3vR3ecZpSayUM
         tqLm8FZNYsTgQ44xg6P8ytNAewQEiMbFpqe4q8szt4TW1u+GxFnjkJFaBO7bRwmqyq
         /iCq3M9xw6ikBf52Fjx7gPHu3CjrvCOygR8hl8JKQ9mtDPoTc/TGB+pJxG7xpntimj
         HsiSuSCyH/7hA==
Date:   Tue, 5 Jul 2022 09:09:42 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Sean Anderson <sean.anderson@seco.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Walle <michael@walle.cc>
Subject: Re: [PATCH v4 1/4] arm64: dts: ls1028a: Update SFP binding to
 include clock
Message-ID: <20220705010942.GS819983@dragon>
References: <20220630223207.1687329-1-sean.anderson@seco.com>
 <20220630223207.1687329-2-sean.anderson@seco.com>
 <9448e378-35cd-a39c-869c-845605cbee84@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9448e378-35cd-a39c-869c-845605cbee84@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 04, 2022 at 10:27:40AM +0200, Krzysztof Kozlowski wrote:
> On 01/07/2022 00:32, Sean Anderson wrote:
> > The clocks property is now mandatory. Add it.
> > 
> > Fixes: eba5bea8f37f ("arm64: dts: ls1028a: add efuse node")
> > Signed-off-by: Sean Anderson <sean.anderson@seco.com>
> > Reviewed-by: Michael Walle <michael@walle.cc>
> 
> The subjects of all these 4 patches are confusing - you did not
> update/add any binding here. These are not bindings.

Right, I replaced 'binding' with 'node' during applying.

Shawn
