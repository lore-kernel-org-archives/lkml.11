Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F08EC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Feb 2022 20:25:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343535AbiBQUZz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Feb 2022 15:25:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343590AbiBQUZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 15:25:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94EF7166E01;
        Thu, 17 Feb 2022 12:25:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 38CD1B8249A;
        Thu, 17 Feb 2022 20:25:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE7D1C340E8;
        Thu, 17 Feb 2022 20:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645129529;
        bh=5GCoE9LSgyVtdfoY5AYvI9+Rwt6pV+Ejt4MpLecQ8sc=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=uh5X0a5GPM7I4pW1/PwV0z0L7XdhkW9X5C2O4Bqxj6I1AEHE+T/prN4evQEzaiDbP
         IYyoeLXjGbNZyaVhDK0vBgYY7/IluySi98IhgNpR5XYrL/Q+1+oBOfeyRvesaGKTnD
         BaaR/yNvRCSYRWpI4U+qCvs0Ycdbh+LOptgT7sHV3Z+SoXi+91kdndl7PdTrVDvH4v
         Vaw4hMyi3vHxjzPUmEH9KITmKD/vQ41lVzzLG9i5nwx8a9vRjMSGP7PbKVQyhAKzZq
         tcKtjQPEPxkKDOyGpztDyu4AyLuX/Kf4arepO5DQSWZttkOsZWTwJ3oUdEX/LlXMS5
         f8BbBpoE/cWug==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220208124034.414635-14-wenst@chromium.org>
References: <20220208124034.414635-1-wenst@chromium.org> <20220208124034.414635-14-wenst@chromium.org>
Subject: Re: [PATCH v3 13/31] clk: mediatek: pll: Implement unregister API
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
Date:   Thu, 17 Feb 2022 12:25:28 -0800
User-Agent: alot/0.10
Message-Id: <20220217202529.AE7D1C340E8@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chen-Yu Tsai (2022-02-08 04:40:16)
> The PLL clk type within the MediaTek clk driver library only has a
> register function, and no corresponding unregister function. This
> means there is no way for its users to properly implement cleanup
> and removal.
>=20
> Add a matching unregister function for the PLL type clk.
>=20
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> Reviewed-by: Miles Chen <miles.chen@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> ---

Applied to clk-next
