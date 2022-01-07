Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87709C433EF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jan 2022 02:27:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345395AbiAGC1c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jan 2022 21:27:32 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:39822 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344503AbiAGC1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 21:27:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B302BB824A4;
        Fri,  7 Jan 2022 02:27:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4975FC36AE3;
        Fri,  7 Jan 2022 02:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641522449;
        bh=3deO5J5WF8oVmHIVSHZ6znm+WwoicJjOuwpVUj/yQWs=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=j33VayXL/izvfQNPweBSsk9B9SMlsnrhS5PJuXW6bvaEeDDh25csKS2MfhzfbD9/j
         sC8ABYO2GBjUn4qkfbJ+WJTaI9G9w4Y0Yed8tdVhJlmwbKpVi26bYZwrEanobKwclW
         pcQtw/XK5S0QIrx6bBwYJGSv0oJs6muKKw8o7mZgUg41E9K84e/3AQTZMXLHO6cVhu
         h05ynRcNmoAnEXmJTdW8Ho2//UJ7xHR5dyhBF3mkQPBpoBV3RhXgL5pQYW69HMMMPl
         fmj8v7Sd/x9ssXfW/n3n869fC7wgyk8pPpwWE6VU1riKiUsiPd3l8LmzQfPN/YtPbV
         qYK5Y49byUocg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220103143712.46675-1-angelogioacchino.delregno@collabora.com>
References: <20220103143712.46675-1-angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH 1/2] clk: mediatek: clk-gate: Shrink by adding clockgating bit check helper
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        miles.chen@mediatek.com, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, mturquette@baylibre.com
Date:   Thu, 06 Jan 2022 18:27:27 -0800
User-Agent: alot/0.9.1
Message-Id: <20220107022729.4975FC36AE3@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting AngeloGioacchino Del Regno (2022-01-03 06:37:11)
> Add a clockgating bit check helper and use it in functions
> mtk_cg_bit_is_cleared(), mtk_cg_bit_is_set() to shrink the
> file size.
>=20
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> ---

Applied to clk-next
