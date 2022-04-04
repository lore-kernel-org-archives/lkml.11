Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7CD2C433EF
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Apr 2022 10:11:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356599AbiDDKN3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Apr 2022 06:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356604AbiDDKNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 06:13:00 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF9B526106;
        Mon,  4 Apr 2022 03:11:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 1F5A7CE16A1;
        Mon,  4 Apr 2022 10:11:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06527C34111;
        Mon,  4 Apr 2022 10:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649067061;
        bh=nJkVGpRJ4QFhxFFiltuU3yvu/ZNypWBwG4x0ffNepqU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rukiyjqmCxOh2WJjTvbCZjQjEkTA89BnK5/OfklrtVvKvDlT6IYYI2cnJ2HI65oQc
         Wc5fGzYcwm6EXGQ23aAOGfUjIxnXaz2EcsnfrojNaub4VJclH4OSiE9OO8G+ynEHKH
         iGA3G4yQEzMQZEIooI+eeb9rbnoAuc6QEf3o9euqHHktGUaEIEFS5MRyuLF3qEdPvY
         SBEpKDdVF46kLi/U9lXVmhwbN+VhZORQ0xQYEDVWvc6gXYS/m581xaPO8EbocEcld2
         ZOHKpa8r7gnbhirFCM798+zs/OL9dLtj1EDvvXXxkRAtkTr13CcCePzogpCFMn7+VH
         IzWyI4Sotr0+g==
From:   Will Deacon <will@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Julia Lawall <Julia.Lawall@inria.fr>
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: fix typos in comments
Date:   Mon,  4 Apr 2022 11:10:47 +0100
Message-Id: <164906471660.24999.13636840572566484133.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220318103729.157574-10-Julia.Lawall@inria.fr>
References: <20220318103729.157574-10-Julia.Lawall@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Mar 2022 11:37:05 +0100, Julia Lawall wrote:
> Various spelling mistakes in comments.
> Detected with the help of Coccinelle.
> 
> 

Applied to arm64 (for-next/fixes), thanks!

[1/1] arm64: fix typos in comments
      https://git.kernel.org/arm64/c/dd671f16b1cd

(I squashed in the hw_breakpoint typo fix as well)

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
