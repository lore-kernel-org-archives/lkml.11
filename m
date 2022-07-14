Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17A37C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jul 2022 10:48:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237289AbiGNKsd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jul 2022 06:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238483AbiGNKsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 06:48:25 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B106651406;
        Thu, 14 Jul 2022 03:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XohSnVoV4/1lapZbhGBzX2/x+DHxkPY5UG2ab+3neEw=; b=MziSggPty3ej2uD1YfMBwconmS
        1f1LjggwlXHkmCjf8EvrkcJMFYuZfMo5gyndLt+GS3m29klzYZ5UB8iwXY3bwd9GkrpLlh8iwg+Qh
        PIGGXMO84HlmxCTwDm4slMY9WEM+2rzr4a8ROntmdlPdm9n/30UL90FzecQW2wvgOBgMvGHHGNUu4
        ZL1x0+aiMDgDqx7DEBpcsHJQ0PutUzPfUBzRJ+JQO7ek+fLfsRIASxtvBX1eTyoMMotaTM2+V2mQ5
        dZ7wtIpu1dE2GtcyQzLlMWfYG6fFK5jq8biA/YFvZutry/xjboDsRCCT5BQ2eqOcCw64h8dgd2/La
        br7+6K5w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oBwOI-003oqI-VN; Thu, 14 Jul 2022 10:48:19 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id E26E6980120; Thu, 14 Jul 2022 12:48:17 +0200 (CEST)
Date:   Thu, 14 Jul 2022 12:48:17 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] objtool: Fix spelling mistake "teh " -> "the"
Message-ID: <Ys/0cXFRssinOqRE@worktop.programming.kicks-ass.net>
References: <20220714102856.22512-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220714102856.22512-1-colin.i.king@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2022 at 11:28:56AM +0100, Colin Ian King wrote:
> There is a spelling mistake in a WARN_FUNC message. Fix it.

That was so on purpose... :-)
