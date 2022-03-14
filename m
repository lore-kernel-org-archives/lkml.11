Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E12EC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Mar 2022 15:13:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235108AbiCNPO3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Mar 2022 11:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234533AbiCNPO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 11:14:26 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 440442DEF
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 08:13:12 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7033B1F37E;
        Mon, 14 Mar 2022 15:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1647270791; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jBSpS/m09xNMY5vCWklpEoUaUMpCXrL9CuXnHnOJ8FA=;
        b=cfz95yY+x09OKCe4IzHCi7gQyB+w8K+vx2EHslRxgc85vKOkCNkeazbRpY/t+jqoHL4TWg
        GAT9Rcy0Hcn1aYKu0mO3dA6V8+K5VlY/il97x+9IVgcelldFpR218ChEM2hYGGSXwNwG7x
        69zGRlyQ69BebyTmo6USwDvBQneBSKw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1647270791;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jBSpS/m09xNMY5vCWklpEoUaUMpCXrL9CuXnHnOJ8FA=;
        b=vAT7nYNXRCBrH+W9wufewXF71/cdEmtswyB6Su3/AlAhm7ydOrwH513tuckuc84OLQcPL3
        zw5Oj883y9DWzCAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E228813B35;
        Mon, 14 Mar 2022 15:13:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id x/3gM4ZbL2JyDQAAMHmgww
        (envelope-from <osalvador@suse.de>); Mon, 14 Mar 2022 15:13:10 +0000
Date:   Mon, 14 Mar 2022 16:13:09 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Abhishek Goel <huntbag@linux.vnet.ibm.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm: Only re-generate demotion targets when a numa
 node changes its N_CPU state
Message-ID: <Yi9bhXSADpNt6WEC@localhost.localdomain>
References: <20220310120749.23077-1-osalvador@suse.de>
 <87mthxb514.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <YisK2PEkKAqtZPfp@localhost.localdomain>
 <87czip73b4.fsf@yhuang6-desk2.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87czip73b4.fsf@yhuang6-desk2.ccr.corp.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 14, 2022 at 09:03:59AM +0800, Huang, Ying wrote:
> Oscar Salvador <osalvador@suse.de> writes:
> On host machine, PMEM is always exposed via memory hotplug.  But later
> on, we found that for guest system it's possible for PMEM to be exposed
> as normal memory.

Could you please elaborate on that? How is it done? I would love to hear the
details.

Thanks


-- 
Oscar Salvador
SUSE Labs
