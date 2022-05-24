Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 342C9C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 24 May 2022 11:15:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236409AbiEXLPg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 May 2022 07:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbiEXLPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 07:15:32 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C43B6B03A
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 04:15:30 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4L6s7L641vz4xZ5;
        Tue, 24 May 2022 21:15:26 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     tyreld@linux.ibm.com, Haowen Bai <baihaowen@meizu.com>
Cc:     paulus@samba.org, linux-kernel@vger.kernel.org, oohall@gmail.com,
        benh@kernel.crashing.org, ruscur@russell.cc, mpe@ellerman.id.au,
        linuxppc-dev@lists.ozlabs.org
In-Reply-To: <1652232476-9696-1-git-send-email-baihaowen@meizu.com>
References: <08d9470c-20db-52b8-7015-84f0ed29ad0c@linux.ibm.com> <1652232476-9696-1-git-send-email-baihaowen@meizu.com>
Subject: Re: [PATCH V2] powerpc/eeh: Drop redundant spinlock initialization
Message-Id: <165339058873.1718562.5563457249542011872.b4-ty@ellerman.id.au>
Date:   Tue, 24 May 2022 21:09:48 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 May 2022 09:27:56 +0800, Haowen Bai wrote:
> slot_errbuf_lock has declared and initialized by DEFINE_SPINLOCK,
> so we don't need to spin_lock_init again, drop it.
> 
> 

Applied to powerpc/next.

[1/1] powerpc/eeh: Drop redundant spinlock initialization
      https://git.kernel.org/powerpc/c/3def164a5cedad9117859dd4610cae2cc59cb6d2

cheers
