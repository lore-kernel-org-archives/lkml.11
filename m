Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32197C433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jul 2022 18:53:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235890AbiGWSxG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jul 2022 14:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbiGWSxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 14:53:04 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C701EAE6;
        Sat, 23 Jul 2022 11:53:03 -0700 (PDT)
Received: from g550jk.localnet (31-151-115-246.dynamic.upc.nl [31.151.115.246])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id C056CCC0D2;
        Sat, 23 Jul 2022 18:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1658602351; bh=C6HfR4astpKVkxBzzghifT5f2iu0l3CRggJRt27F3sI=;
        h=From:To:Subject:Date:In-Reply-To:References;
        b=Yeef8N9HYRGCUE4aGbSBqyHGiE3+euacvgwD0JUG20kYUVpirGHEO5kFs8nzrs34I
         fnkY4SIslG8eOH6WNqw4yHBcO2gdDEz86P7ofnEbhadFK0iKJCFv1jaTTEjl4I/zNC
         669+bFLeUS8B1d50hJnhuL+RWbSWTiuYJOShz1dk=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2 3/3] ARM: qcom_defconfig: order items with savedefconfig
Date:   Sat, 23 Jul 2022 20:52:31 +0200
Message-ID: <2109260.irdbgypaU6@g550jk>
In-Reply-To: <c5150e83-0e50-3be6-b6bd-bf30fe5e94d1@linaro.org>
References: <20220721155356.248319-1-krzysztof.kozlowski@linaro.org> <2246145.ElGaqSPkdT@g550jk> <c5150e83-0e50-3be6-b6bd-bf30fe5e94d1@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Samstag, 23. Juli 2022 20:44:08 CEST Krzysztof Kozlowski wrote:
> On 23/07/2022 20:17, Luca Weiss wrote:
> > On Samstag, 23. Juli 2022 19:36:17 CEST Krzysztof Kozlowski wrote:
> >> On 23/07/2022 11:58, Luca Weiss wrote:
> >>> See also
> >>> https://lore.kernel.org/linux-arm-msm/20191104210943.101393-1-luca@z3ntu
> >>> .x
> >>> yz/ (never applied for some reason)
> >> 
> >> Mentioned patch is incorrect so should not be applied - it removes at
> >> least TMPFS which is not desired. I did not check other removed symbols.
> > 
> > For this example: TMPFS is still enabled after this, it's selected by
> > other
> > options, like DRM or COMMON_CLK.
> 
> I know, it does not matter. We had this case (with DEBUGFS and probably
> others) and the decision was - user visible symbols must no be removed
> by savedefconfig.

So savedefconfig is "broken" (not doing the correct thing) then or what? Sounds 
like a topic for kconfig maintainers?

> 
> > Imo not doing this just hides the brokeness as options wouldn't get
> > selected anyways when you do "make qcom_defconfig". Savedefconfig
> > afterwards just puts reality into the defconfig file. And yes, if some
> > option gets lost then some dependency for it probably needs to get
> > enabled as well and this should get fixed.
> 
> But dependencies are no being enabled, because expectation is that all
> user-visible options are selected by defconfig.
> 
> 
> Best regards,
> Krzysztof




