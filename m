Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2A4EC0502C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Aug 2022 22:21:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbiH2WVn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Aug 2022 18:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbiH2WVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 18:21:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA6367D793;
        Mon, 29 Aug 2022 15:21:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 85704612B8;
        Mon, 29 Aug 2022 22:21:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6A3BC433D6;
        Mon, 29 Aug 2022 22:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661811699;
        bh=bq8keTFpMZ7l2im1Ns0/z0Mn38AX0kvR2B/xrBLzHAc=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=q40hJNM2U39JmOqBEaP93tEOK0DYENeTo8l7thse7i0xGteDeedl0jgP49EsGsx37
         9eRBOCk5rLdHiFbfYjEZZjlY5+rwAzCz61UEJ4hDsyP8vn9KIJ5mMe0mpaColXP6Vo
         19iDJdIQ+UGwKAVUEPrWvth06jyQZQcW41hNwwdf28KsYgew7F/xmath8x1rTR5eau
         1fapkvf0OzZ4eUe4Tlg1K9ogIAZxi2BBVxozEWuPvXloVYPaWm7bB2gH7lGhzziT1a
         kzSOpLfA3opSMxNytSy/3Jsmzrn5L48obh+qvgE6GXOnhhGNHFHAxOa1t+01jZ6cCn
         90t76k5ZsNq6w==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220828130113.5845-1-krzysztof.kozlowski@linaro.org>
References: <20220828130113.5845-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] dt-bindings: mfd: qcom,spmi-pmic: extend example
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 29 Aug 2022 15:21:37 -0700
User-Agent: alot/0.10
Message-Id: <20220829222139.D6A3BC433D6@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Krzysztof Kozlowski (2022-08-28 06:01:13)
> Add a more complete example with PM6150 to provide better validation of
> the bindings.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
