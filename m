Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 109C2C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Jul 2022 06:46:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234042AbiGGGqq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Jul 2022 02:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbiGGGqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 02:46:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ED1E2BB05;
        Wed,  6 Jul 2022 23:46:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3E8FB6223F;
        Thu,  7 Jul 2022 06:46:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99C16C3411E;
        Thu,  7 Jul 2022 06:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657176401;
        bh=gDTI6bzgacZUyQ+597yklj8txJRTgWrcbiEyQEYawhU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z73EBgtTyLs60Emr/xosib2dxdXvy3uMBdbaIJ0eVgs8Lj5Joq8ssaqU3nQtERQLR
         I2ncGzqmkvJ2VfrrszcIdKo39Lua4giwgLnULAbHNharPwFZuImvVvUBjGAg3ZY3UD
         /cvKzwDRFHONViYS/siA+90/tWvmBXT6AM9bz9/zK6YbkoGcAQBjaeDlAxKBjcXHCU
         ggKkos86tg9mJJdCpk0u1Lop7gVkUrlQ0XzyVhL3J1ys2n3GWK6cNULI4Wb4e07fAr
         I1OYLk7AGtCWOMGnzHE7dnr8jmhyqJ82XFgDckj0fsAoAClUKQMzsfpvKVqz7zXmG+
         NBSurjWS06AyA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1o9LHf-00048G-Io; Thu, 07 Jul 2022 08:46:43 +0200
Date:   Thu, 7 Jul 2022 08:46:43 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/14] arm64: dts: qcom: msm8998: drop USB PHY clock index
Message-ID: <YsaBU4YZEjxL/9uO@hovoldconsulting.com>
References: <20220705114032.22787-1-johan+linaro@kernel.org>
 <20220705114032.22787-7-johan+linaro@kernel.org>
 <61281f98-f45c-4701-f21e-269c5e78881a@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61281f98-f45c-4701-f21e-269c5e78881a@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 05, 2022 at 04:09:14PM +0300, Dmitry Baryshkov wrote:
> On 05/07/2022 14:40, Johan Hovold wrote:
> > The QMP USB PHY provides a single clock so drop the redundant clock
> > index.
> > 
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> 
> However please note 
> https://lore.kernel.org/linux-arm-msm/20220620071936.1558906-3-dmitry.baryshkov@linaro.org/ 
> (for this and the last patch).

Ah, I had not seen that one. Bjorn appears to have applied your series
before this one so these two patches became empty and were dropped.

Thanks for reviewing!

Johan
