Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78421C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Feb 2022 00:55:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231510AbiB1Azt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Feb 2022 19:55:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231203AbiB1Azq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 19:55:46 -0500
X-Greylist: delayed 302 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 27 Feb 2022 16:55:07 PST
Received: from ciao.gmane.io (ciao.gmane.io [116.202.254.214])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D83FC47063
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 16:55:06 -0800 (PST)
Received: from list by ciao.gmane.io with local (Exim 4.92)
        (envelope-from <glk-linux-kernel-4@m.gmane-mx.org>)
        id 1nOUEj-0003yc-QB
        for linux-kernel@vger.kernel.org; Mon, 28 Feb 2022 01:50:01 +0100
X-Injected-Via-Gmane: http://gmane.org/
To:     linux-kernel@vger.kernel.org
From:   Samuel Bronson <naesten@gmail.com>
Subject: Re: [PATCH v3 1/8] riscv: Avoid unaligned access when relocating modules
Date:   Fri, 25 Feb 2022 23:48:41 -0500
Message-ID: <87zgme6xna.fsf@DESKTOP-5JD7O8D.localdomain>
References: <20220224152456.493365-1-kernel@esmil.dk>
        <20220224152456.493365-2-kernel@esmil.dk>
Mime-Version: 1.0
Content-Type: text/plain
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
Cancel-Lock: sha1:mColZ0E90tcqhrcGvi1sG17CQfs=
Cc:     linux-riscv@lists.infradead.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Emil Renner Berthing <kernel@esmil.dk> writes:

> With the C-extension regular 32bit instructions are not
> necessarily aligned on 4-byte boundaries. RISC-V instructions
> are in fact an ordered list of 16bit native-endian
> "parcels", so access the instruction as such.

Hold on a minute, this is what it says in my copy of the Unprivileged
ISA:

,----
| RISC-V base ISAs have either little-endian or big-endian memory systems,
| with the privileged architecture further defining bi-endian operation.
| Instructions are stored in memory as a sequence of 16-bit *little-endian*
| parcels, regardless of memory system endianness.  Parcels forming one
| instruction are stored at increasing halfword addresses, with the
| *lowest-addressed parcel holding the lowest-numbered bits* in the
| instruction specification.
`----
[Emphasis mine.]

In other words, the parcels are little endian, and they're arranged in
little-endian order.  System endianness doesn't matter, it collapses to
plain old little-endian.

(I'm really not sure why they describe the ordering in such a
round-about way; I assume that's the source of the confusion here?)

