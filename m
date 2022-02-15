Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22F6DC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Feb 2022 02:26:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233570AbiBOC0i (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Feb 2022 21:26:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbiBOC0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 21:26:36 -0500
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE2325C9;
        Mon, 14 Feb 2022 18:26:23 -0800 (PST)
Received: from pecola.lan (unknown [159.196.93.152])
        by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 36B3F2015A;
        Tue, 15 Feb 2022 10:26:20 +0800 (AWST)
Message-ID: <9f042114f8ac89a59dca9759f3e866de41fcf811.camel@codeconstruct.com.au>
Subject: Re: [PATCH v2] mctp: fix use after free
From:   Jeremy Kerr <jk@codeconstruct.com.au>
To:     trix@redhat.com, matt@codeconstruct.com.au, davem@davemloft.net,
        kuba@kernel.org, nathan@kernel.org, ndesaulniers@google.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Date:   Tue, 15 Feb 2022 10:26:19 +0800
In-Reply-To: <20220215020541.2944949-1-trix@redhat.com>
References: <20220215020541.2944949-1-trix@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tom,

> Clang static analysis reports this problem
> route.c:425:4: warning: Use of memory after it is freed
>   trace_mctp_key_acquire(key);
>   ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> When mctp_key_add() fails, key is freed but then is later
> used in trace_mctp_key_acquire().  Add an else statement
> to use the key only when mctp_key_add() is successful.
> 
> Fixes: 4f9e1ba6de45 ("mctp: Add tracepoints for tag/key handling")
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
> v2: change the Fixes: line

Super, thanks!

Acked-off-by: Jeremy Kerr <jk@codeconstruct.com.au>

Cheers,


Jeremy
