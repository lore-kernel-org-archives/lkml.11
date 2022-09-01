Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 685F1ECAAD3
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Sep 2022 17:55:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232649AbiIARzZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Sep 2022 13:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234107AbiIARzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 13:55:17 -0400
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 802D81145D
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 10:55:14 -0700 (PDT)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 281Hmx4r031531;
        Thu, 1 Sep 2022 12:48:59 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 281Hmwrg031525;
        Thu, 1 Sep 2022 12:48:58 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Thu, 1 Sep 2022 12:48:58 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Gabriel Paubert <paubert@iram.es>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Zhouyi Zhou <zhouzhouyi@gmail.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2] powerpc: Fix irq_soft_mask_set() and irq_soft_mask_return() with sanitizer
Message-ID: <20220901174858.GG25951@gate.crashing.org>
References: <c0b486e782b6695092dcdb2cd340a3d44c8c266d.1661272738.git.christophe.leroy@csgroup.eu> <CMJ3VICKD1CI.SVFJOKYJPKZQ@bobo> <e022754d-b4d3-bc9f-cc79-2cf556180459@csgroup.eu> <CMJ8P06JA9OY.1S8VDV2XRU3W5@bobo> <7c11b659-5b8e-256c-508e-39395041fccb@csgroup.eu> <20220831224522.GX25951@gate.crashing.org> <ad5ebb37-6b6f-372c-dd07-fc4cfc5f5fe5@csgroup.eu> <YxBhRtTuJ4Ut7wUt@lt-gp.iram.es> <24253442-9878-c5ed-cbaa-05a5c4851a6e@csgroup.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <24253442-9878-c5ed-cbaa-05a5c4851a6e@csgroup.eu>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2022 at 07:47:10AM +0000, Christophe Leroy wrote:
> Le 01/09/2022 à 09:37, Gabriel Paubert a écrit :
> > Agree, but there is one thing which escapes me: why is r3 listed in the
> > outputs section (actually as a read write operand with the "+"
> > constraint modifier) but is not used after the asm which is the last
> > statement of function returning void?
> > 
> > Do I miss something?
> 
> As far as I remember, that's to tell GCC that r3 register is modified by 
> the callee. As it is an input, it couldn't be listed in the clobber list.

Inputs can be clobbered just fine, in general.  But here the operand
is tied to a register variable, and that causes the error ("'asm'
specifier for variable 'r3' conflicts with 'asm' clobber list").

Marking it in/out here is more appropriate anyway :-)


Segher
