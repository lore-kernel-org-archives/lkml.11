Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81B24C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 30 May 2022 07:06:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233276AbiE3HGY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 May 2022 03:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbiE3HGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 03:06:22 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24C0B71A1C;
        Mon, 30 May 2022 00:06:21 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id E67821C0B8A; Mon, 30 May 2022 09:06:19 +0200 (CEST)
Date:   Mon, 30 May 2022 09:06:19 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Luca Weiss <luca@z3ntu.xyz>
Cc:     linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andr?? Almeida <andrealmeid@collabora.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: qcom: msm8974-hammerhead: Add notification LED
Message-ID: <20220530070618.GC1363@bug>
References: <20220505164336.13210-1-luca@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220505164336.13210-1-luca@z3ntu.xyz>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> From: Andr?? Almeida <andrealmeid@collabora.com>
> 
> Nexus 5 has a RGB LED connected to the TRILED and hence channels 7, 6 and
> 5 of the LPG. Add a node describing this.
> 
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> Signed-off-by: Andr?? Almeida <andrealmeid@collabora.com>

> --- This patch depends on the PM8941 LPG patch: 
> https://lore.kernel.org/linux-arm-msm/20220504205411.1510667-1-bjorn.andersson@linaro.org/

How does this LED end up looking in userland? We want to make sure all the phone RGB status LEDs 
end up using same path in /sys/..

Best regards,

									Pavel
