Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0322C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Mar 2022 18:02:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343932AbiCWSE1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Mar 2022 14:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343949AbiCWSEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 14:04:21 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E6CA88B03
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 11:02:51 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id A3E54210F4;
        Wed, 23 Mar 2022 18:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1648058569; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PH6z87ZT6oLdaXVcqGtAs/3h7ivkY3xB/i0TfcTIX5U=;
        b=jv8WdjAtfSPahs8a0C++jvpJEJDKQ+fsP21x42FtoS69DQROpOhlReP14kr2DY2KhnF1N1
        YuFgd8cE7bKVNnyU1G8ysaULWhsAPs3Pfgl/GSbfDFQxdTfexeEVlDsPcgTlm9tnSBhYl4
        2VLx6nxSj5oaDLJOqbG0uePwa3b22xM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1648058569;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PH6z87ZT6oLdaXVcqGtAs/3h7ivkY3xB/i0TfcTIX5U=;
        b=SCqhS6nM2K2a36VQe2YNroDZ/MzJFif/cIueWn7mxCBYA1ausDCAYM75kA6ZfJpu+hqce5
        0kMTRuKSQQ+mHeCg==
Received: from pobox.suse.cz (pobox.suse.cz [10.100.2.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 12FEDA3B88;
        Wed, 23 Mar 2022 18:02:48 +0000 (UTC)
Date:   Wed, 23 Mar 2022 19:02:47 +0100 (CET)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Sathvika Vasireddy <sv@linux.ibm.com>
cc:     linuxppc-dev@lists.ozlabs.org, jpoimboe@redhat.com,
        peterz@infradead.org, linux-kernel@vger.kernel.org, aik@ozlabs.ru,
        mpe@ellerman.id.au, rostedt@goodmis.org,
        naveen.n.rao@linux.vnet.ibm.com
Subject: Re: [RFC PATCH 1/3] objtool: Move common code to utils.c
In-Reply-To: <20220318105140.43914-2-sv@linux.ibm.com>
Message-ID: <alpine.LSU.2.21.2203231859420.10670@pobox.suse.cz>
References: <20220318105140.43914-1-sv@linux.ibm.com> <20220318105140.43914-2-sv@linux.ibm.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +#define sym_for_each_insn(file, sym, insn)                              \
> +	for (insn = find_insn(file, sym->sec, sym->offset);             \
> +	     insn && &insn->list != &file->insn_list &&                 \
> +		insn->sec == sym->sec &&                                \
> +		insn->offset < sym->offset + sym->len;                  \
> +	     insn = list_next_entry(insn, list))
> +
> +#endif /* UTILS_H */

Since you include <objtool/utils.h> in check.c, you can remove the 
definition of sym_for_each_insn() macro from check.c as well.

I wonder if it would make sense to move all these helper functions to 
utils.c and utils.h. Might be connected to what Josh wrote about his work 
on objtool interface.

Regards
Miroslav
