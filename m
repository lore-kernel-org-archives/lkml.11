Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62FB5C32774
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Aug 2022 23:16:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238547AbiHVXQR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Aug 2022 19:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237609AbiHVXQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 19:16:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC3235508B;
        Mon, 22 Aug 2022 16:16:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6C789B816BF;
        Mon, 22 Aug 2022 23:16:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEAC4C433C1;
        Mon, 22 Aug 2022 23:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661210172;
        bh=B2Y5JUCF/4c7ZF4VA8jpWgREXwA5XU5ETca1S/Tanso=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=POgBZiyfISDr5jP0axhmFmU+s090JJ0Wd9EJpqL/GzoCRWDNBn4B8+phtdRxEOfpE
         7AXDJaRKfxRwylq1tMsfyo9bnLcvNOhL//2LDfIG49w2r4TO3Qp0PS72JY/cU6o0m6
         gqPSZatyjtkxI9I7atrJxB67ZdOUD73kKzW7zIKXYJS415wAcPt8BY8q4DLX+tyeA/
         mRRB6G8GI2DixYZifxqZEHYNsgFnXfvM+g/3hk1S1cUcxXbhCPQ6olnKSPCywsOIXi
         ciXxlsGZDQn5I93CxA96r0+1hYY0Ti7f5hwVQMBPLJr3yuEc+wqW85H0As3xL8/UwU
         tkcBU/AM3KLbQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220727131015.2073100-1-conor.dooley@microchip.com>
References: <20220727131015.2073100-1-conor.dooley@microchip.com>
Subject: Re: [PATCH] dt-bindings: clock: gpio-gate-clock: Convert to json-schema
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Jyri Sarha <jsarha@ti.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     Conor Dooley <conor.dooley@microchip.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>
Date:   Mon, 22 Aug 2022 16:16:09 -0700
User-Agent: alot/0.10
Message-Id: <20220822231611.DEAC4C433C1@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Conor Dooley (2022-07-27 06:10:16)
> Convert the simple GPIO clock gate Device Tree binding to json-schema
> and fix-up references to this file in other text format bindings.
> Jyri Sarha is the file's only editor/author so they have been added as
> maintainer of the new yaml binding.
>=20
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---

Applied to clk-next
