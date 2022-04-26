Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38E50C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Apr 2022 00:13:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239821AbiDZAQu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Apr 2022 20:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239846AbiDZAQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 20:16:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3AEF120124;
        Mon, 25 Apr 2022 17:13:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A42961670;
        Tue, 26 Apr 2022 00:13:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2099C385A4;
        Tue, 26 Apr 2022 00:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650932019;
        bh=eRwehzqDzCrayIYVH26k9aBHvRm08jjwSZxL8YRhjSI=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=c+BdUZKOb2pllE/jeguFXWXuCu2GEdkLAHy6YGUlbDNLYBHdJA9R0ORPUMuWYEK1f
         bL9MQhwn4/xbv/ehrdk7tWo8M0gCAOugaBt05Rtpr2SgGeox6o3SOZIddjRyc4J1Rw
         yNM0FSa4tLrtP8ZHw1i623ZS2VDQSz0P8lBk32ZUwmQKhADV1lGAwHLVsOJSQfZgjs
         BZxAdknJi6QZwZNdyD+McRB8KtiMg3CN+oBe6gAzpssPzWQBLo2H3fax0hhPuSOHB4
         JV721n8qm9HQ6o/Y8iQWmHb9CM353Zxc1Ha2dFaD+MP+9q2xnpOocFGUI/EfpPAPW3
         F9f4RjFFYglYw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220409132251.31725-12-chun-jie.chen@mediatek.com>
References: <20220409132251.31725-1-chun-jie.chen@mediatek.com> <20220409132251.31725-12-chun-jie.chen@mediatek.com>
Subject: Re: [PATCH v5 11/15] clk: mediatek: Add MT8186 vdecsys clock support
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
Date:   Mon, 25 Apr 2022 17:13:37 -0700
User-Agent: alot/0.10
Message-Id: <20220426001339.C2099C385A4@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chun-Jie Chen (2022-04-09 06:22:47)
> Add MT8186 vdec clock controller which provide clock gate
> control for video decoder.
>=20
> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> Reviewed-by: Miles Chen <miles.chen@mediatek.com>
> ---

Applied to clk-next
