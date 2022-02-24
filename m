Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B8EAC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Feb 2022 22:09:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235253AbiBXWKC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Feb 2022 17:10:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235150AbiBXWKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 17:10:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC04B28570B;
        Thu, 24 Feb 2022 14:09:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A0E83B829BE;
        Thu, 24 Feb 2022 22:09:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BE46C340E9;
        Thu, 24 Feb 2022 22:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645740567;
        bh=8gOW2ZHLzzZeS1mimTB1wzQtbyNCGuLwdXgh3TcoMWc=;
        h=In-Reply-To:References:Subject:From:To:Date:From;
        b=MsmOPt3+ccFbOLdsDpiB0b1TJzSeCrjR4DRKRHWvdO/HHaj/DBygGywUEU5ZljbID
         VQzUjdaqGM2Aziqma4+YhtcW05OOu8X7cfcQ300AvOmborQBqHzQmjZtJCdMz88fCp
         WbTbgHrD1acwp6AIeLHeJ1k5kMIqxooiPx2dKx26QmTdZHjKUHJOwxf7M5S4Hk6Bss
         6RtG2gg5gy580C+mxJ+F7h3F5GaHdi77aL/MODQVuUuE2sZ4Us9TI0WZJK61N+d2eT
         TMksvhkCBACtbHgKNZ7BYt1DL3XomdsPL37uM71EM1vs+8Vsp4B9GOsV8FX64/TOdX
         0h3O9Yr7Joolg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220224164831.21475-7-ansuelsmth@gmail.com>
References: <20220224164831.21475-1-ansuelsmth@gmail.com> <20220224164831.21475-7-ansuelsmth@gmail.com>
Subject: Re: [PATCH v5 06/15] clk: qcom: gcc-ipq806x: use ARRAY_SIZE for num_parents
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
Date:   Thu, 24 Feb 2022 14:09:25 -0800
User-Agent: alot/0.10
Message-Id: <20220224220927.3BE46C340E9@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Ansuel Smith (2022-02-24 08:48:22)
> Use ARRAY_SIZE for num_parents instead of hardcoding the value.
>=20
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
