Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34CF5C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Mar 2022 19:57:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344455AbiCWT6v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Mar 2022 15:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232629AbiCWT6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 15:58:49 -0400
Received: from isilmar-4.linta.de (isilmar-4.linta.de [136.243.71.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63B3C8BF55
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 12:57:19 -0700 (PDT)
X-isilmar-external: YES
X-isilmar-external: YES
Received: from owl.dominikbrodowski.net (owl.brodo.linta [10.2.0.111])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 1385D2000B1;
        Wed, 23 Mar 2022 19:57:18 +0000 (UTC)
Received: by owl.dominikbrodowski.net (Postfix, from userid 1000)
        id 77D52803DB; Wed, 23 Mar 2022 20:51:16 +0100 (CET)
Date:   Wed, 23 Mar 2022 20:51:16 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] random: re-add removed comment about
 get_random_{u32,u64} reseeding
Message-ID: <Yjt6NJGromYyAb+/@owl.dominikbrodowski.net>
References: <20220323042336.148775-1-Jason@zx2c4.com>
 <Yjt0AX8st/gE00CM@owl.dominikbrodowski.net>
 <CAHmME9r7+tU6sU80opW-cyw4srsnOpLTsUKUv2Qdfs-DtPYekw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHmME9r7+tU6sU80opW-cyw4srsnOpLTsUKUv2Qdfs-DtPYekw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Am Wed, Mar 23, 2022 at 01:45:22PM -0600 schrieb Jason A. Donenfeld:
> Hi Dominik,
> 
> Good point; might as well take this opportunity to firm up that
> wording. How about:
> 
> "... and do not invoke reseeding until the buffer is emptied."

Yes, that sounds better. Though "integer family of functions" still sounds a
bit ambiguous.

Thanks,
	Dominik
