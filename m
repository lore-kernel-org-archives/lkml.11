Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6CADC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Feb 2022 05:49:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbiBVFuH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Feb 2022 00:50:07 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:35872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbiBVFuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 00:50:06 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2238A99684
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 21:49:42 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CEB862110A;
        Tue, 22 Feb 2022 05:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1645508980; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BkIA/JWUizWaSzVXc+cHsIZabhRqa+eFVctIr/ke4+4=;
        b=R3k0izTI0bNJdjiF/1ZSYa+oZ+a+OikZcLJbX7yrj72adA5ky67hHV9O1VRpvzRhat1GcA
        kn0fm56ZMcNUs/PGrdCzUAOu55LuiHxK8K+5RAq5yocWIkTFh7IdRHVMJnTZo8zkkj1+GZ
        UVGKh+zZuRsNq+jHw9L32ZWjC3NxW/g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1645508980;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BkIA/JWUizWaSzVXc+cHsIZabhRqa+eFVctIr/ke4+4=;
        b=HOBi92SPsQQ8U0fTCw11s8WfIt8wuJDN5CP77ZnNQXK/pfek+wN9PSOflpX1EJHIcoGvjP
        XPgUWeSzEYyk9rCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4578D13BB5;
        Tue, 22 Feb 2022 05:49:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id KY5gDXR5FGK1BQAAMHmgww
        (envelope-from <osalvador@suse.de>); Tue, 22 Feb 2022 05:49:40 +0000
Date:   Tue, 22 Feb 2022 06:49:38 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v1] drivers/base/memory: clarify adding and removing of
 memory blocks
Message-ID: <YhR5coy7OGyjwQtx@localhost.localdomain>
References: <20220221154531.11382-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220221154531.11382-1-david@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 21, 2022 at 04:45:31PM +0100, David Hildenbrand wrote:
> Let's make it clearer at which places we actually add and remove memory
> blocks -- streamlining the terminology -- and highlight which memory
> block start out online and which start out as offline.
> 
> * rename add_memory_block -> add_boot_memory_block
> * rename init_memory_block -> add_memory_block
> * rename unregister_memory -> remove_memory_block
> * rename register_memory -> __add_memory_block
> * add add_hotplug_memory_block
> * mark add_boot_memory_block with __init (suggested by Oscar)
> 
> __add_memory_block() is  a pure helper for add_memory_block(), remove
> the somewhat obvious comment.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Thanks for doing this, it makes the code much more clear.

Reviewed-by: Oscar Salvador <osalvador@suse.de>

> ---
> 
> Based on v5.17-rc5 and:
> 	[PATCH v2 0/2] drivers/base/memory: determine and store zone for
> 	single-zone memory blocks [1]

Maybe just my thing, but I also had to pull in [1] in order to apply
this error-free. 

[1] https://patchwork.kernel.org/project/linux-mm/patch/20220128144540.153902-1-david@redhat.com/


-- 
Oscar Salvador
SUSE Labs
