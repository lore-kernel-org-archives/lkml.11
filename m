Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E678BC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Apr 2022 00:12:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239546AbiDZAPl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Apr 2022 20:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239558AbiDZAPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 20:15:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D87E62107;
        Mon, 25 Apr 2022 17:12:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D6DA861675;
        Tue, 26 Apr 2022 00:12:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34238C385A7;
        Tue, 26 Apr 2022 00:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650931951;
        bh=vA73MI2Edm0kG6iJkmPOdF6VPS0x9Y+IxTI+Yo9VjM4=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=bwPbSANP9cowh4N8EReTEFDitYDIG9rsjEf42SE/pZ+bcA/fSre+3DaYDF6Rb7/t4
         NzmaQrmiQYvafA5GJTL3LNMx2D1aDPPteSz53OOwQiXWyJxfTG4a0A6vplLm6FSnMX
         fc/PC0n0iHq/lS6ZcqZuJ1ZEG0tvIaSFHMo2JHqeeswH7kS5tP6QpQgh8UrsDwgVYI
         /QjntaOPsO9mN1+SNenzJRUEhEekj7VWw1NnRbnB3Cof8OCNJgnIubHgi42x/VjTev
         ouZQ9+SiPXcLxfDcgsEewKXeEo8ECRrOAvM+y5UrmD5XMstzyr/h91FC6A8HA2vMIj
         tooFNEOSmJIWw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220409132251.31725-5-chun-jie.chen@mediatek.com>
References: <20220409132251.31725-1-chun-jie.chen@mediatek.com> <20220409132251.31725-5-chun-jie.chen@mediatek.com>
Subject: Re: [PATCH v5 04/15] clk: mediatek: Add MT8186 infrastructure clock support
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
Date:   Mon, 25 Apr 2022 17:12:29 -0700
User-Agent: alot/0.10
Message-Id: <20220426001231.34238C385A7@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chun-Jie Chen (2022-04-09 06:22:40)
> Add MT8186 infrastructure clock controller which provides
> clock gate control for basic IP like pwm, uart, spi and so on.
>=20
> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> Reviewed-by: Miles Chen <miles.chen@mediatek.com>
> ---

Applied to clk-next
