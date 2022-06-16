Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26FF6C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jun 2022 00:38:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347635AbiFPAiQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jun 2022 20:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241061AbiFPAiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 20:38:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F3F13D3B;
        Wed, 15 Jun 2022 17:38:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 24D1761B1D;
        Thu, 16 Jun 2022 00:38:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2240AC3411A;
        Thu, 16 Jun 2022 00:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655339892;
        bh=cWWAkAmTLB5aFZm061WYGM85uXQwNZYKsHtM7mOFquY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rMBUm1fNr+ABKQ2bugrj26iqTnyjiYlDnvPEAg8Exu9o2QK00GmZ9PRuHckQaW9lc
         FBrzASEcqIOr8E2TCBoYaVNrz3XQ37ko6RSSCFB6OpzTHpy0jbpllPXkF0CpsFL/UR
         wk3qxSknjzXtIvzrktY7ZxCoDna/vtir85WQj1K2FJ6ZJge7ZFNqmyI0+0+dgONZSI
         oP2GNWtH0Tj7YZKQmFaZPf2oT0FntBBlmWpGZeUXm7s+tM/4QWCH5dVvT2aL9yQ72d
         Wf8J6YihvVT0yXXqCZ1v73/sgBspqfrPR71iQeV61F0ESY/acw8SdfoyPB1aj+oHaq
         FVu5V8m0M/M0g==
Date:   Wed, 15 Jun 2022 17:38:11 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Michal Simek <michal.simek@xilinx.com>, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] net: axienet: Fix spelling mistake "archecture"
 -> "architecture"
Message-ID: <20220615173811.52dbd496@kernel.org>
In-Reply-To: <20220614064647.47598-1-colin.i.king@gmail.com>
References: <20220614064647.47598-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Jun 2022 07:46:47 +0100 Colin Ian King wrote:
> There is a spelling mistake in a dev_err message. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Did not apply to net-next, please respin/
