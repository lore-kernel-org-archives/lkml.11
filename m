Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3B55C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jun 2022 12:17:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233384AbiF2MRI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jun 2022 08:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233400AbiF2MQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 08:16:32 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C37FF35245
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 05:16:26 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LY0n35MwDz4xDH;
        Wed, 29 Jun 2022 22:16:23 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     linuxppc-dev@lists.ozlabs.org, kernel test robot <lkp@intel.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <26f8b72a4276c0bd8ed63860c7316f6361c351b4.1655978907.git.christophe.leroy@csgroup.eu>
References: <26f8b72a4276c0bd8ed63860c7316f6361c351b4.1655978907.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/powermac: Remove empty function note_scsi_host()
Message-Id: <165650493014.3004956.6600560027462595950.b4-ty@ellerman.id.au>
Date:   Wed, 29 Jun 2022 22:15:30 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Jun 2022 12:08:36 +0200, Christophe Leroy wrote:
> note_scsi_host() has been an empty function since
> commit 6ee0d9f744d4 ("[POWERPC] Remove unused old code
> from powermac setup code").
> 
> Remove it.
> 
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/powermac: Remove empty function note_scsi_host()
      https://git.kernel.org/powerpc/c/d7f396461518c766b2436d64b6d3ba6a4c418dcf

cheers
