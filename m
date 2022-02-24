Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62652C433FE
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Feb 2022 22:11:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235311AbiBXWME (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Feb 2022 17:12:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232144AbiBXWMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 17:12:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE0DDF09;
        Thu, 24 Feb 2022 14:11:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C92F561AD8;
        Thu, 24 Feb 2022 22:11:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BF5FC340E9;
        Thu, 24 Feb 2022 22:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645740690;
        bh=/OUCuSDrUCWeyWmBocueXw65Cse/abtUx2PYxjhgQ8c=;
        h=In-Reply-To:References:Subject:From:To:Date:From;
        b=afF5jssa4xg3U8p4TwBdYH3x6B2445PEvu5/DEgqPt8ddmL9PadXLwHds47Xh3SRy
         1Sc/nW7g0q3jLZ4zpl7b9MhgZTZTkkXePxXpdZPGSxGhsDqFb96t25glkAIzxN1wg9
         Df4v3Cjg/krKyEfp3Y92/McPIFR0SJydlQx9OWyZUk4y3aNveHrclFPNLj4uPonBIy
         2CxC7KlfFZ6G+Wt1lRygV6rqszWla62PjvuR8FF8z4ETvJyIOmOWLONJBXe2s31JOG
         1K0Cnz9xBxSNRa87A44tGxYF8NXkFIeMS5R5I0lO3iFzSjV3roTwf7L3YhR1eIs66R
         LTJEhKibUb30g==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220224164831.21475-11-ansuelsmth@gmail.com>
References: <20220224164831.21475-1-ansuelsmth@gmail.com> <20220224164831.21475-11-ansuelsmth@gmail.com>
Subject: Re: [PATCH v5 10/15] clk: qcom: gcc-ipq806x: add additional freq for sdc table
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
Date:   Thu, 24 Feb 2022 14:11:28 -0800
User-Agent: alot/0.10
Message-Id: <20220224221130.2BF5FC340E9@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Ansuel Smith (2022-02-24 08:48:26)
> Add additional freq supported for the sdc table. The ops are changed to
> the floor_ops to handle a freq request of 52kHz where we need to provide
> a freq of 51.2kHz instead for stability reason.
>=20
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
