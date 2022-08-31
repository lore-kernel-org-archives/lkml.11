Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39912ECAAD1
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Aug 2022 06:43:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbiHaGn1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Aug 2022 02:43:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiHaGnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 02:43:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01421BFA94;
        Tue, 30 Aug 2022 23:43:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5648B61798;
        Wed, 31 Aug 2022 06:43:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7DBEC433C1;
        Wed, 31 Aug 2022 06:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661928202;
        bh=WoLISpqhfcnuWC4zl5jPNUTle9pxaCdIo+0c6WbDNcs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WMOdheE0TC4GATwxjAMSgLPT9/fVYUTGB3FeaZwnqz7b/jyYxJvx3OeIA/xWiQPiN
         rLfwJURRpsWrMclPFOe2FWCWTUU8euw6qQcyfiRUnGdFVGMns4hq6qaw+5JHeI4KS8
         yWe2WvCAfnAs1xcVk6zELj9SNTrJgn3NCY8ntVTg+SLp/h7e81K4Za8yy2mYcZhbEw
         +9vJvO71ut9GaUKdE0hlWum6E2ZVebFzoTQAEcudSTQuU9XP+8/rw5QHrHdxps8t1h
         /o/x96MW0cJ+JNwqthLmzd9XU1sios0RDQjWaNXtNCqhVcOGzuEAN3pTUM05qKRwmL
         o5PM/Wod4N1jA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oTHRY-0006Ec-En; Wed, 31 Aug 2022 08:43:20 +0200
Date:   Wed, 31 Aug 2022 08:43:20 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andrew Halaney <ahalaney@redhat.com>,
        Mark Brown <broonie@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/6] arm64: dts: qcom: sc8280xp-crd: Specify which LDO
 modes are allowed
Message-ID: <Yw8DCM0Hqxr9ncoO@hovoldconsulting.com>
References: <20220829164952.2672848-1-dianders@chromium.org>
 <20220829094903.v2.3.Ie7d2c50d2b42ef2d364f3a0c8e300e5ce1875b79@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220829094903.v2.3.Ie7d2c50d2b42ef2d364f3a0c8e300e5ce1875b79@changeid>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 29, 2022 at 09:49:49AM -0700, Douglas Anderson wrote:
> This board uses RPMH, specifies "regulator-allow-set-load" for LDOs,
> but doesn't specify any modes with "regulator-allowed-modes".
> 
> Prior to commit efb0cb50c427 ("regulator: qcom-rpmh: Implement
> get_optimum_mode(), not set_load()") the above meant that we were able
> to set either LPM or HPM mode. After that commit (and fixes [1]) we'll
> be stuck at the initial mode. Discussion of this has resulted in the
> decision that the old dts files were wrong and should be fixed to
> fully restore old functionality.
> 
> Let's re-enable the old functionality by fixing the dts.
> 
> [1] https://lore.kernel.org/r/20220824142229.RFT.v2.2.I6f77860e5cd98bf5c67208fa9edda4a08847c304@changeid
> 
> Fixes: ccd3517faf18 ("arm64: dts: qcom: sc8280xp: Add reference device")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> Reviewed-by: Andrew Halaney <ahalaney@redhat.com>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> ---
> 
> Changes in v2:
> - Rebased atop ("...: sc8280xp-crd: disallow regulator mode switches")

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
