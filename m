Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32D51C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Apr 2022 19:21:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347681AbiDRTYd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Apr 2022 15:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347675AbiDRTYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 15:24:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A05F32EFB;
        Mon, 18 Apr 2022 12:21:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BA7C460E0A;
        Mon, 18 Apr 2022 19:21:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E06CEC385A7;
        Mon, 18 Apr 2022 19:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650309709;
        bh=F240PBxYpZla1ryYurxeW3a9XB9s9HfDW2MUlKI6Vbg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Rwn6Y11bbLWi+nF98Ulkecx6wNaKwvJDes4P2FyJCc3b+FxgF41dIX3dK/z1h2Z8T
         jTK4xD/u0ReEvlmNQt/qkncoB364auvKToGPCkjvSCbzQ7Sw9GP5XcHmgFp3LfWpdU
         1Uf2fFdLzqBDW5eEX4KUC2nwTOt11fUJj6+Hs9XF2MwwIRrUsmwTrceBcWtERPm89k
         HrKqY32ZwKUHOY/aRSrECZxkaCdWOFmYdNIN5uSx3o+mzzdtZ8uvovFVbALOPcwLVq
         FgN/5hipZIZeQJcwNHfBkkTx2AY3bWXCUBzfiX8KcgnZ2OFmXxWUjCiBrjD1NN/lC4
         iDEu5FVxIvRVQ==
Message-ID: <0999f8ef-0df9-9226-8e7b-f6ed2a6b16b7@kernel.org>
Date:   Mon, 18 Apr 2022 12:21:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] ARC: Remove a redundant memset()
Content-Language: en-US
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Vineet Gupta <vgupta@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-snps-arc@lists.infradead.org
References: <98e53b48968d3c29be44f6a302a04e64e5b59f08.1647978533.git.christophe.jaillet@wanadoo.fr>
From:   Vineet Gupta <vgupta@kernel.org>
In-Reply-To: <98e53b48968d3c29be44f6a302a04e64e5b59f08.1647978533.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/22/22 12:49, Christophe JAILLET wrote:
> disasm_instr() already call memset(0) on its 2nd argument, so there is no
> need to clear it explicitly before calling this function.
>
> Remove the redundant memset().
>
> Signed-off-by: Christophe JAILLET<christophe.jaillet@wanadoo.fr>


Applied.

Thx,
-Vineet
