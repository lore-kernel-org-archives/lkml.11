Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD003C43334
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jun 2022 18:42:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349935AbiFJSmK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jun 2022 14:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346639AbiFJSmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 14:42:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B40AC113B49;
        Fri, 10 Jun 2022 11:42:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4E08B621AC;
        Fri, 10 Jun 2022 18:42:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B840C34114;
        Fri, 10 Jun 2022 18:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654886525;
        bh=NENNkFJr9jYYklV27x0XlIpa/LcG4dbeezdHX97GwK4=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=fUta4A84kEUtsm7ddSAblIqlL87cgvTZ4a8HrNwr4C23BrM0Hey1illCxSLfYX7jy
         U8IIID6gR1v4OuRxOPj+ryIcsZeFWKV0yaZnx8hhJpoPrCox5uZxQm0fa74igHG5BU
         1ayTYILzpVZ0P+wsvrjqBCS+ivrcFhM/ko1a7voHMYVpcK7yyRSJSAxs1prG7lVtYi
         Rsi9RCe4VlGpUvcV4fR/5fTLzj3rtZzcEe7iB3alYjKW8UroIisOyKa03tNwCWjWnK
         0CTT71TyzZdEk1vCuSzLUchCUIfXhCVchPtP7GP44NNkGP4vSgRM9iwnDMQ0fL5pva
         PmygosvWNjeag==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220523102339.21927-2-matthias.bgg@kernel.org>
References: <20220523102339.21927-1-matthias.bgg@kernel.org> <20220523102339.21927-2-matthias.bgg@kernel.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: ARM: Mediatek: Remove msdc binding of MT8192 clock
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     allen-kh.cheng@mediatek.com, weiyi.lu@mediatek.com,
        chun-jie.chen@mediatek.com, linux-kernel@vger.kernel.org,
        ikjn@chromium.org, miles.chen@mediatek.com, robh+dt@kernel.org,
        linux-mediatek@lists.infradead.org,
        krzysztof.kozlowski+dt@linaro.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        angelogioacchino.delregno@collabora.com,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        devicetree@vger.kernel.org
To:     matthias.bgg@kernel.org, mturquette@baylibre.com
Date:   Fri, 10 Jun 2022 11:42:03 -0700
User-Agent: alot/0.10
Message-Id: <20220610184205.9B840C34114@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting matthias.bgg@kernel.org (2022-05-23 03:23:38)
> From: Matthias Brugger <matthias.bgg@gmail.com>
>=20
> The code controlling msdc clock gate was moved inthe the consumer, the MMC
> driver. This node did never represent a working implementation of any
> peripheral. It was just a lonely clock gate that wasn't used. Delete the
> binding description of this node.
>=20
> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> Reviewed-by: Miles Chen <miles.chen@mediatek.com>
>=20
> ---

Applied to clk-next
