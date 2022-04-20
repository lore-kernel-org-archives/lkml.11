Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF75FC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Apr 2022 17:25:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381062AbiDTR2O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Apr 2022 13:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243846AbiDTR2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 13:28:11 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C56B911158
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 10:25:24 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 85F341F380;
        Wed, 20 Apr 2022 17:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1650475523; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hW35aaWMw7O5l+yQpLHqvh+EdGfGpAJ9E4lIYu5Ygac=;
        b=WByZIgwaddM2P0oAhOWY53PcD9HevHmTN24HN1y+Gl0iXc2tkS12J64qJmZ8kDY0kUhHwj
        EE9rGxaSShnVpOgG5gav8BYVRwhLMzrF/WMJ1EQ9KrVVDC/Vu2fNzPOwLAWlohlalJFMyh
        qb/Se6hq2zTKUtEz/hIYMR5Y0/e2BUg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1650475523;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hW35aaWMw7O5l+yQpLHqvh+EdGfGpAJ9E4lIYu5Ygac=;
        b=nc6Yz+LeI0OZgMvnoS57ahERA0zGXRUK1SHiXSgIY98koPPChRDAWlApPIqw/CA3qZk0jG
        imzDQqhkRiZNbcCg==
Received: from pobox.suse.cz (pobox.suse.cz [10.100.2.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 6A53B2C145;
        Wed, 20 Apr 2022 17:25:23 +0000 (UTC)
Date:   Wed, 20 Apr 2022 19:25:23 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
cc:     x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 24/25] objtool: Remove --lto and --vmlinux in favor
 of --link
In-Reply-To: <dcd3ceffd15a54822c6183e5766d21ad06082b45.1650300597.git.jpoimboe@redhat.com>
Message-ID: <alpine.LSU.2.21.2204201917400.1205@pobox.suse.cz>
References: <cover.1650300597.git.jpoimboe@redhat.com> <dcd3ceffd15a54822c6183e5766d21ad06082b45.1650300597.git.jpoimboe@redhat.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -static void init_insn_state(struct insn_state *state, struct section *sec)
> +static void init_insn_state(struct objtool_file *file, struct insn_state *state,
> +			    struct section *sec)

file is not needed anymore here.

Miroslav
