Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDCD6C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jul 2022 20:03:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237006AbiGMUDv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jul 2022 16:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236667AbiGMUDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 16:03:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B068E2DF4;
        Wed, 13 Jul 2022 13:03:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 05403B8214D;
        Wed, 13 Jul 2022 20:03:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EDCCC34114;
        Wed, 13 Jul 2022 20:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657742619;
        bh=WuHHTJxCbMvxN9wOlvDm7LaxQgBF717ppnpA3S+GxJw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Otqhsatk+zG3w/OGnMokbqmkoqhqT+TdezG8+TfKHeMK7CjrnXZ6Ie8LvEb7A8Y+8
         refthA7uSe93O7E9rXehuO0kU/a9MX9dsYLXlQ8sWAwUshIV278Otlz7MkmnIE0JZD
         Tuqr9mdYtta8lkwTgidRGFw5zKelRtbKDSdK196Sgv1tFr6QK8BYMCJGvCqMtTKnD1
         HegdRWGVJi4evBKktBfrRQi4pgcQJZoUfgoh+BiIqA1AXRSarL5fwmWLergtiMvXwB
         Kr42lqFg9G4pqlWFcg8/HO9+UShkiEXMDBNI8905xf3QcY+dqs6BwYvFFL5dyKQp1k
         6sNjrlgEJeR4w==
Received: by pali.im (Postfix)
        id D5D069D9; Wed, 13 Jul 2022 22:03:36 +0200 (CEST)
Date:   Wed, 13 Jul 2022 22:03:36 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: marvell: Fix compatible strings for Armada
 3720 boards
Message-ID: <20220713200336.addvyfjhakrx72am@pali>
References: <20220713125644.3117-1-pali@kernel.org>
 <a9e1ccb7-6caa-2f7c-b879-b3ff4945794c@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a9e1ccb7-6caa-2f7c-b879-b3ff4945794c@linaro.org>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 13 July 2022 21:42:43 Krzysztof Kozlowski wrote:
> On 13/07/2022 14:56, Pali Rohár wrote:
> > All Armada 3720 boards have Armada 3720 processor which is of Armada 3700
> > family and do not have Armada 3710 processor. So none of them should have
> > compatible string for Armada 3710 processor.
> > 
> > Fix compatible string for all these boards by removing wrong processor
> > string "marvell,armada3710" and adding family string "marvell,armada3700"
> > as the last one. (Note that this is same way how are defined Armada 3710
> > DTS files).
> 
> Please do not introduce some changes just in DTS, but start from the
> bindings. Someone wrote the bindings like that and expected to be that
> way, so first change the bindings with proper rationale. Then change the
> DTS files.
> 
> 
> Best regards,
> Krzysztof

Ok, I tried to update bindings and fix example in it, see patch:
https://lore.kernel.org/linux-devicetree/20220713200123.22612-1-pali@kernel.org/
