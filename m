Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF046C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jun 2022 13:21:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234445AbiF3NVO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jun 2022 09:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbiF3NVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 09:21:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 618BD2E681;
        Thu, 30 Jun 2022 06:21:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1F27FB82A59;
        Thu, 30 Jun 2022 13:21:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78C15C341D4;
        Thu, 30 Jun 2022 13:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1656595269;
        bh=v1yk3EJqrZe7WElMnRYbMQ3vWrinzVVFUOpJyHpQhA0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sj8UQABMfDGfzcVV7qLMqjBBgHBex9CyEPc7bz6i9l7MOtori5nq6aiFmBS1+j+zH
         JK86uRmZSUylTVp9Weu98PnY1XCLTWzDhtibld8St903bS5N3ZXCkttsglixHC+Kx3
         BLEQVgQ7+IPgA+BT2doJOxzzQqULaJi1wYqdS2W0=
Date:   Thu, 30 Jun 2022 15:21:06 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     stable@vger.kernel.org, Hsin-Yi Wang <hsinyi@chromium.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Will Deacon <will@kernel.org>, Sasha Levin <sashal@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH stable 4.9] fdt: Update CRC check for rng-seed
Message-ID: <Yr2jQvgVkyw6RWbB@kroah.com>
References: <20220628160111.2237376-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220628160111.2237376-1-f.fainelli@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2022 at 09:01:09AM -0700, Florian Fainelli wrote:
> From: Hsin-Yi Wang <hsinyi@chromium.org>
> 
> commit dd753d961c4844a39f947be115b3d81e10376ee5 upstream
> 
> Commit 428826f5358c ("fdt: add support for rng-seed") moves of_fdt_crc32
> from early_init_dt_verify() to early_init_dt_scan() since
> early_init_dt_scan_chosen() may modify fdt to erase rng-seed.
> 
> However, arm and some other arch won't call early_init_dt_scan(), they
> call early_init_dt_verify() then early_init_dt_scan_nodes().
> 
> Restore of_fdt_crc32 to early_init_dt_verify() then update it in
> early_init_dt_scan_chosen() if fdt if updated.
> 
> Fixes: 428826f5358c ("fdt: add support for rng-seed")
> Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Will Deacon <will@kernel.org>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  drivers/of/fdt.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)

All now queued up, thanks.

greg k-h
