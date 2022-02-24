Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B26ABC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Feb 2022 22:11:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235296AbiBXWLs (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Feb 2022 17:11:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232144AbiBXWLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 17:11:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCFAF28F97C;
        Thu, 24 Feb 2022 14:11:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A4F3C61AF6;
        Thu, 24 Feb 2022 22:11:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02187C340F4;
        Thu, 24 Feb 2022 22:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645740672;
        bh=MvBJLsVT0xCdWImaYGVAhN1RTfBfMzlH+FYSHHqmVSM=;
        h=In-Reply-To:References:Subject:From:To:Date:From;
        b=Tde1OnNqvBh0vf6eGS05RI9ikn/uKyQGBPJPwpMMkK8X87dAv3B67jivijheE1yxd
         j3s0Wyfw50gmQPx2fxNbobT66eYdXx/uVygbhXOlER5e1DYSD8+P9LVD91xbiPdtmu
         shs0XHGO1xWlCW/64ZTpwI9pb1Q/YOTTEXCZapfwjeEYKgX8RmEoogEwITFJN4iREG
         hT8IFJt69JahJb98cKI1EXtVAuhTvtW1p5V9JLRTtBN2NoHB1xltoOcqGakt3/6UyC
         6F6XlUEGPzFI1ZQ7x6JE9nmYJAqJD1DVxqJ5BbQLw3xWpDy6ldSwYjrRIGUmjLvQpc
         yemWb2IMeU6pQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220224164831.21475-10-ansuelsmth@gmail.com>
References: <20220224164831.21475-1-ansuelsmth@gmail.com> <20220224164831.21475-10-ansuelsmth@gmail.com>
Subject: Re: [PATCH v5 09/15] clk: qcom: clk-rcg: add clk_rcg_floor_ops ops
From:   Stephen Boyd <sboyd@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Taniya Das <tdas@codeaurora.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 24 Feb 2022 14:11:10 -0800
User-Agent: alot/0.10
Message-Id: <20220224221112.02187C340F4@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Ansuel Smith (2022-02-24 08:48:25)
> Add clk_rcg_floor_ops for clock that can't provide a stable freq and
> require to use a floor freq to provide the requested frequency.
>=20
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
