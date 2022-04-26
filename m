Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6435BC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Apr 2022 00:12:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237961AbiDZAPL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Apr 2022 20:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbiDZAPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 20:15:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A47B45504;
        Mon, 25 Apr 2022 17:12:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A3E616166E;
        Tue, 26 Apr 2022 00:12:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4623C385A4;
        Tue, 26 Apr 2022 00:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650931924;
        bh=2cinohATxPD5jIOjLzdaNPIP5C9FIyAkI8AzF3YNoaU=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=iOUDS1uCgZ5NV/o6YT3TLhIpF/e/JOfqlNY+wqwbvekbkOfCGbRdqFAQlNxegWOOr
         3xrDpswREEqCUCQVwldihOvYkz+1z3yMWoYH/ZDXBFE2MBu+6b4L0LX+Easoyi+J/S
         11MIu6JC1QxSpkyxdDm4g8MiKYtDLgirl3T+MDqDCjz3u85UPOu6gYbMgCPkO3+zy/
         D5XBmvavXxSXG+TnKHQTNQCDlDSKznkWpdD9pHcOyGEmwiJg1k5iULEuJndtOyUYCY
         OUxZiJxs0mFMPQEDXHkYLzeRIGNc7Vq3xfmfqO8luOKrctWacHzt1NjguVJA1KNq94
         bQQhhRgTblFoQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220409132251.31725-2-chun-jie.chen@mediatek.com>
References: <20220409132251.31725-1-chun-jie.chen@mediatek.com> <20220409132251.31725-2-chun-jie.chen@mediatek.com>
Subject: Re: [PATCH v5 01/15] dt-bindings: ARM: MediaTek: Add new document bindings of MT8186 clock
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
Date:   Mon, 25 Apr 2022 17:12:01 -0700
User-Agent: alot/0.10
Message-Id: <20220426001203.E4623C385A4@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chun-Jie Chen (2022-04-09 06:22:37)
> This patch adds the new binding documentation for system clock
> and functional clock on MediaTek MT8186.
>=20
> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---

Applied to clk-next
