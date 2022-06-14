Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B25C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jun 2022 07:36:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354779AbiFNHgo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jun 2022 03:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354728AbiFNHgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 03:36:43 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03A033EB89
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 00:36:42 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1D5241F8DC;
        Tue, 14 Jun 2022 07:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1655192200; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fxQagflCaO4GgUwtJ3AVLjpKRmorvkUqSxV0Ora8B44=;
        b=Fz/QXSpS8dF2oQ8gD2tMfHUOlw5gEHden5sqKyUOl8vj5ZxJPN7lwCwwphPsaDePx/46F+
        cKF6s9hLheRA5gBOjjTrXsulxkFZcmqgGeNnAdTLJyDayHXPKupFfYOmtLiHI56oUV+rA7
        x+lAJN14IYeJjDV43GHpSkqOZFAcmic=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1655192200;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fxQagflCaO4GgUwtJ3AVLjpKRmorvkUqSxV0Ora8B44=;
        b=E1KnMSTZzPdVHo9TYVK4TZ1vRJU86Oi6BzYz9/IiV4dN7I0N0FWN7LRzxgnnapsOx80A9K
        d9xjhLelRJmlzmCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BB9E5139EC;
        Tue, 14 Jun 2022 07:36:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id SCW5Koc6qGKABgAAMHmgww
        (envelope-from <osalvador@suse.de>); Tue, 14 Jun 2022 07:36:39 +0000
Date:   Tue, 14 Jun 2022 09:36:38 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v1] MAINTAINERS: add MEMORY HOT(UN)PLUG section and add
 myself as reviewer
Message-ID: <Yqg6hlrGXbB9Xnhz@localhost.localdomain>
References: <20220610101258.75738-1-david@redhat.com>
 <72194595-a177-088d-28a9-0a24d4192777@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72194595-a177-088d-28a9-0a24d4192777@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2022 at 08:58:55AM +0200, David Hildenbrand wrote:
> (thanks for the kind words from reviewers :) )
> 
> Thinking about it (and remembering having a discussion about
> submaintainers for MM in general at LSF/MM):
> 
> @Andrew, do we want "official" submaintainers for that section? If so,
> we could turn my R into an M. Further, Oscar did a lot of work in the
> memory hot(un)plug world as well -- so if we want submaintainers, Oscar
> might be a very good fit as well.

I would be glad to take on such role, officially, alongside David, and I think
this can benefit this area.


-- 
Oscar Salvador
SUSE Labs
