Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EDDEC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jun 2022 07:03:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233032AbiF2HDu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jun 2022 03:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232828AbiF2HDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 03:03:32 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A5663D1CB
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 00:01:29 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LXsng4t4mz4xNm;
        Wed, 29 Jun 2022 17:01:27 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     linuxppc-dev@lists.ozlabs.org,
        Liam Howlett <liam.howlett@oracle.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>
In-Reply-To: <20220624011745.4060795-1-Liam.Howlett@oracle.com>
References: <20220624011745.4060795-1-Liam.Howlett@oracle.com>
Subject: Re: [PATCH] powerpc/prom_init: Fix kernel config grep
Message-Id: <165648606483.2953426.15827591769571638131.b4-ty@ellerman.id.au>
Date:   Wed, 29 Jun 2022 17:01:04 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Jun 2022 01:17:58 +0000, Liam Howlett wrote:
> When searching for config options, use the KCONFIG shell variable so
> that builds using non-standard config locations work.
> 
> 

Applied to powerpc/fixes.

[1/1] powerpc/prom_init: Fix kernel config grep
      https://git.kernel.org/powerpc/c/6886da5f49e6d86aad76807a93f3eef5e4f01b10

cheers
