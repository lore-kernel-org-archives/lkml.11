Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C010C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Mar 2022 21:55:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238483AbiCIV4h (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Mar 2022 16:56:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234811AbiCIV4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 16:56:35 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0439972AE
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 13:55:32 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 28C361F381;
        Wed,  9 Mar 2022 21:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1646862931; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=E0v4Okq/Vwj1DkpbTQ/9vduUBRNNE2OxrDnwQN8oagM=;
        b=kgCMDQHjfIweWJ7IUKQ5lam5cwnoZap9GTsGimg8VSK2YPD0BvdEIJH6QJdnWgioPhM/iD
        eF0oKqZUjCuUom072AYgJ6EWiracAgdKaQfecIlJk6KOwGlQZnpWJNxZdQ6XiukLWR5pjE
        sZKa8K4fWRBV08qdsHvwkX2JmfeQcMA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1646862931;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=E0v4Okq/Vwj1DkpbTQ/9vduUBRNNE2OxrDnwQN8oagM=;
        b=HCURMcqzfjDCSbhpPyiVULe4R9gh3HN3BvV8xFmDkWlWF0hQToZV7w1lZ0VbJgEexWr8BL
        h7Xob+aZzdDEbtCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B37C513D7F;
        Wed,  9 Mar 2022 21:55:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id pjYlKFIiKWIzdgAAMHmgww
        (envelope-from <osalvador@suse.de>); Wed, 09 Mar 2022 21:55:30 +0000
Date:   Wed, 9 Mar 2022 22:55:29 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Abhishek Goel <huntbag@linux.vnet.ibm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: Only re-generate demotion targets when a numa node
 changes its N_CPU state
Message-ID: <YikiUbWCb3VSrJzV@localhost.localdomain>
References: <20220309144644.4278-1-osalvador@suse.de>
 <20220309130249.60733272aafb3bd5f2e6b88c@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220309130249.60733272aafb3bd5f2e6b88c@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2022 at 01:02:49PM -0800, Andrew Morton wrote:
> On Wed,  9 Mar 2022 15:46:44 +0100 Oscar Salvador <osalvador@suse.de> wrote:
> > +static inline void set_migration_target_nodes() {}
> 
> Compiler won't like that.  Please test (compile and runtime) with
> CONFIG_HOTPLUG_CPU=n.

Sorry, fat fingers. This on top:

diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index c64fe2923fb0..b82b4a9a0136 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -51,7 +51,7 @@ extern bool numa_demotion_enabled;
 #ifdef CONFIG_HOTPLUG_CPU
 extern void set_migration_target_nodes(void);
 #else
-static inline void set_migration_target_nodes() {}
+static inline void set_migration_target_nodes(void) {}
 #endif
 #else

I will wait for some feedback before sending a v2.

thanks Andrew!

-- 
Oscar Salvador
SUSE Labs
