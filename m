Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B193C32793
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Aug 2022 00:54:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232633AbiHXAyQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Aug 2022 20:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232878AbiHXAyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 20:54:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BFF6883EE;
        Tue, 23 Aug 2022 17:54:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BE2B461742;
        Wed, 24 Aug 2022 00:54:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2143CC433C1;
        Wed, 24 Aug 2022 00:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661302452;
        bh=vb1AoOQnvMSkt7W/efbuY6c35sEFtEFY9X4IOcZc6fg=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=YDmtMnEP0j48a/JH6JpCC03D4EoNdh5sPuGYHss02A2qPsZRGpqMtexY5VE2jNCt6
         JYzjhm1Phnv6Dcl3r4h/h+HAvE9qPrkO/K0Vrv0Eeav0zcDnYbgwqvgE9HMAMx6ZBS
         XzVYaOjuaFqAaIkJT3UngrZPo3zxqnixaZglAXtpSkYUp1qyXbqlMCOyFglLLhGtig
         rxFIS7Gi4CxRWdBzJM7/RoeevgGv4tsGfufi6Hojk6BXqaldsY2U0eodgFAjV3eNOf
         Ij9BPsYK0W6bKku6KHSs6hYD8pwP4R/dTWpCxZ9hewFgtArY4pvbiVlRNVoR3htUw0
         wvPqxCVpq2PTQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220630151205.3935560-2-claudiu.beznea@microchip.com>
References: <20220630151205.3935560-1-claudiu.beznea@microchip.com> <20220630151205.3935560-2-claudiu.beznea@microchip.com>
Subject: Re: [PATCH 2/2] clk: do not initialize ret
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea@microchip.com>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        mturquette@baylibre.com
Date:   Tue, 23 Aug 2022 17:54:10 -0700
User-Agent: alot/0.10
Message-Id: <20220824005412.2143CC433C1@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Claudiu Beznea (2022-06-30 08:12:05)
> There is no need to initialize ret.
>=20
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---

Applied to clk-next
