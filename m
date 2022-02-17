Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33C21C4332F
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Feb 2022 20:20:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245709AbiBQUUw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Feb 2022 15:20:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237751AbiBQUUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 15:20:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 834A0BAB80;
        Thu, 17 Feb 2022 12:20:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1ADD861DAD;
        Thu, 17 Feb 2022 20:20:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64FBEC340E8;
        Thu, 17 Feb 2022 20:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645129225;
        bh=eEM1/BgSWPu8vdPRMcvM/JdUZ5HQzfFvVqozYQ+s2MY=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=qQxB2c94GHuo8oXJXFS5I7yvT0yW1XRctPNYrv5uxmV3SPceJtUJR5giQw+hryOif
         JSWiSThPabDlY+u4g9gchqcw5dm3pKYcPPOJaaBoxKVhawM9255SelPs8+nQ5My6o/
         TaX93cedd/sYnIZtiUIJgcytOwGRKEGDG5GxCJCYQ8p+KYAX4cxeqL9j+nWaOyCYAR
         mvolesE0BfwomhuGiuZnNh4hi7jCRrwhCfsrpCODKQTQ9fsX4ZzUmUblF775W5OFWU
         cL6jqOqfPrheH1pMZ+eRW69/4n1DOtPWQgclxvcYYneqbrYJXr7V3+W3Dnb28BMJl+
         BhknjDjvXKXYQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220208124034.414635-2-wenst@chromium.org>
References: <20220208124034.414635-1-wenst@chromium.org> <20220208124034.414635-2-wenst@chromium.org>
Subject: Re: [PATCH v3 01/31] clk: mediatek: Use %pe to print errors
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Miles Chen <miles.chen@mediatek.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
To:     Chen-Yu Tsai <wenst@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>
Date:   Thu, 17 Feb 2022 12:20:23 -0800
User-Agent: alot/0.10
Message-Id: <20220217202025.64FBEC340E8@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chen-Yu Tsai (2022-02-08 04:40:04)
> If %pe is used to print errors, a string representation of the error
> would be printed instead of a number as with %ld. Also, all the sites
> printing errors are deriving the error code from a pointer. Using %pe
> is more straightforward.
>=20
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> Reviewed-by: Miles Chen <miles.chen@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> ---

Applied to clk-next
