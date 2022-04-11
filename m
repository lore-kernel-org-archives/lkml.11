Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 040C7C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Apr 2022 14:23:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345071AbiDKOZS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Apr 2022 10:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243554AbiDKOZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 10:25:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAED937002;
        Mon, 11 Apr 2022 07:22:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A1594B815E0;
        Mon, 11 Apr 2022 14:22:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CA37C385A3;
        Mon, 11 Apr 2022 14:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649686972;
        bh=/M3dzgiYPsOBvJvml9NopDHsF9Dgp7f55YskJvFJqLA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S2F1oZ1fjfWrzrneid259jlbR35FVo4a2PDP4YqAgR9pTgeUmkjiMy4kV9TXiToV1
         I2oIU8LITs/fZ5YxvDGY6DyY6PW5KgFijms2pkOTs1BI6K6Ozmv47yHOT9cfOf5Bf6
         WLgGsZk0JI9zDsU54jU1c8Hudeh8ch5APfJu/dQDJWoGeIv0fZFDnqACkbtlAFImoE
         OOPwndO06F7L3gflqoT/9/iKVDVKa5q+8ldQfpSn/JQmnCFHl/bF9PLnOnwJAvbecw
         MFQM65vzsPCtBVAwPFryeLOx0OkQCDpERQFFPfS833SgNdWft1FeSroQhGPd1LPaOm
         /A69AMLetF0Kw==
Date:   Mon, 11 Apr 2022 19:52:48 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine: Remove a useless mutex
Message-ID: <YlQ5uOk4WPXAfV0V@matsya>
References: <7180452c1d77b039e27b6f9418e0e7d9dd33c431.1644140845.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7180452c1d77b039e27b6f9418e0e7d9dd33c431.1644140845.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06-02-22, 10:47, Christophe JAILLET wrote:
> According to lib/idr.c,
>    The IDA handles its own locking.  It is safe to call any of the IDA
>    functions without synchronisation in your code.
> 
> so the 'chan_mutex' mutex can just be removed.
> It is here only to protect some ida_alloc()/ida_free() calls.

Applied, thanks

-- 
~Vinod
