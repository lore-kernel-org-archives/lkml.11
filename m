Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A14FDC433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Mar 2022 12:26:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234761AbiCAM1c (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Mar 2022 07:27:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234758AbiCAM12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 07:27:28 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4531A95A11
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 04:26:47 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: alyssa)
        with ESMTPSA id 1E35A1F42827
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1646137605;
        bh=9NMYT5GTQXgmmpSeRgMayYIsfg6kQLz4BasTs0OF7Tg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n6oKlhDyahEo9QO2MflYK0uTJ2gPIJj/ZcVQpWXEYZtihtoY8unlyi1pHTmRFpuxK
         RNIjLgsZCKOn2X3XH8VfylQkoe15GWo23KFS3zueAEni4gKC7F3LvspC0KPWDxZfa6
         Nagw3EGoytGy3T69jwa0XQj47kXkYo6GHLOncoIFwEvPNhjRDrr+ahmRDUlq+V7loX
         /tyvwRgmtFE3//ASeJ0AfScuLHiRnlh9aqdIwvce/zQqNwglhHAFVWeXHltqGbHuM4
         rFSzQdkRk0Up2zjHs6cd3savhWkqOSwFA6pzy1rVf/UTPI2eaQDCvMEkykmz1xYehr
         EeXgka0/ayOgw==
Date:   Tue, 1 Mar 2022 07:26:38 -0500
From:   Alyssa Rosenzweig <alyssa@collabora.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        linux-mediatek@lists.infradead.org,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nick Fan <Nick.Fan@mediatek.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v2] soc: mediatek: mtk-infracfg: Disable ACP on MT8192
Message-ID: <Yh4Q/qBX9TjPbtzx@maud>
References: <20220215184651.12168-1-alyssa.rosenzweig@collabora.com>
 <e93b12d6-5c7b-2ad6-47e5-c1311d95cba2@collabora.com>
 <470ec036-b402-2cc2-94b9-75ebaff342fc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <470ec036-b402-2cc2-94b9-75ebaff342fc@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Patch applied. I fixed the commit message by deleting the v2 note.

Thank you!
