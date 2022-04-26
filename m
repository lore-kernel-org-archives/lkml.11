Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48F94C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Apr 2022 00:13:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232966AbiDZAQl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Apr 2022 20:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239658AbiDZAQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 20:16:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04DB5120126;
        Mon, 25 Apr 2022 17:13:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9606661670;
        Tue, 26 Apr 2022 00:13:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1360C385B9;
        Tue, 26 Apr 2022 00:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650932011;
        bh=Ow78VkIBAEP36TlYSEZ7SB8Qi7mldmLyeftLK2D/pK4=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=iVk0GsA9BztxcW7kQFzC8MoziAMy2yzq/aRZt9d6VAe+1GfSy0IbduYATQ9HJJWXZ
         Tdo95vEIUS6NPoUPaIZxUtOvgh6EGaHT6eYBrJBFZ5e0xplP8ZbGk/L7eYs0FXltCx
         TCD0v9BnaOwJEgZYucvc7hkEkRzzVCfhYbMbJTu2b/zQThxRbX4xmohRWK7c5netXj
         SLlNvfI6mzFra4/dHuSedKapLfRLRBhXStcNLzlPGGw26Lz0GBdMz7RFz2R52uFRNi
         6HFg+s4aZc4dDzdmaxADPm84P8TTrKl59hTxiE8FuQjdD2TwFzsMCwq2Gm11SoQbsM
         3zV4XRUKwLc0A==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220409132251.31725-11-chun-jie.chen@mediatek.com>
References: <20220409132251.31725-1-chun-jie.chen@mediatek.com> <20220409132251.31725-11-chun-jie.chen@mediatek.com>
Subject: Re: [PATCH v5 10/15] clk: mediatek: Add MT8186 imgsys clock support
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, srv_heupstream@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>
To:     Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh+dt@kernel.org>
Date:   Mon, 25 Apr 2022 17:13:28 -0700
User-Agent: alot/0.10
Message-Id: <20220426001330.F1360C385B9@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chun-Jie Chen (2022-04-09 06:22:46)
> Add MT8186 imgsys clock controllers which provide clock gate
> control for image IP blocks.
>=20
> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> Reviewed-by: Miles Chen <miles.chen@mediatek.com>
> ---

Applied to clk-next
