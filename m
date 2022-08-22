Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4046C28D13
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Aug 2022 23:06:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232177AbiHVXGv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Aug 2022 19:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232256AbiHVXGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 19:06:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCEC543E5E;
        Mon, 22 Aug 2022 16:06:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 667196134B;
        Mon, 22 Aug 2022 23:06:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFF20C433D6;
        Mon, 22 Aug 2022 23:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661209607;
        bh=rgeuZBFqOE86KbbcuzF7iDJSa0+fmJB6mEfGx/OvRGw=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=WZC3GDJ3bV0MXzJFkl+wCVhvtTSb/sELPKXA63f4QeQNiqJ2eeqLzYLldjtdFUaw9
         cy39Qifas1EhEL6Rnq29NIFQ+CmMvwWiNJ1up/ldaMAIWqiMkeOvjI6HNYu8HYh7jM
         CNomiaKNmua92EuUMyhBoNyTfbq298ZRxxSK7cIOaTtEtNW1cGVWb49tJKecOx6CFN
         KglwKUsL4Up+dtC3gk1tRiostScB1bvNA3/ZV6js0siCYZ75AzgVlxy0rSHxlmiCHq
         biHgpwASixvhjH9t7IYJSOyyFkqe0I2PxM8iAY52AOfUCSiYWPhlQoihiC5JYy70cb
         GCbjtfXga26YQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220613081632.2159-2-lukas.bulwahn@gmail.com>
References: <20220613081632.2159-1-lukas.bulwahn@gmail.com> <20220613081632.2159-2-lukas.bulwahn@gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: clock: Move lochnagar.h to dt-bindings/clock
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Luca Ceresoli <luca@lucaceresoli.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        devicetree@vger.kernel.org, patches@opensource.cirrus.com,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Joe Perches <joe@perches.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org
Date:   Mon, 22 Aug 2022 16:06:45 -0700
User-Agent: alot/0.10
Message-Id: <20220822230647.AFF20C433D6@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Lukas Bulwahn (2022-06-13 01:16:31)
> Most of the clock-related dt-binding header files are located in
> include/dt-bindings/clock. It would be good to keep all the similar
> header files at a single location.
>=20
> This was discovered while investigating the state of ownership of the fil=
es
> in include/dt-bindings/ according to the MAINTAINERS file.
>=20
> This change here is similar to commit 8e28918a85a0 ("dt-bindings: clock:
> Move ti-dra7-atl.h to dt-bindings/clock") and commit 35d35aae8177
> ("dt-bindings: clock: Move at91.h to dt-bindigs/clock").
>=20
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---

Applied to clk-next
