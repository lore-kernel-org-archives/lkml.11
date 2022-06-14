Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 141A4CCA47A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jun 2022 12:34:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbiFNMel (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jun 2022 08:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244392AbiFNMe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 08:34:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ABD9F4616D
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 05:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655209863;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CINhQ0TufHi3amSiVTGnrn1sbNNueagVao77jHCIJos=;
        b=W3asntOM2qXCasOtmIcUv/Y46/mRpfgPiBhSfvL+SLHuBh0/OBgERY9gXkElPI2fyvx6VH
        3lg/bFNHMmjyVcpoErAEHGpsRoRQRadGuLoiXHccvJHtp09Y0S/5Md+GlwTEKURHkZL1Hx
        2GXUU1ckUco2/r8cvOhkS0ax2sDP6zY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-601-K4OhpCdxNkGGb0KdB6SrDw-1; Tue, 14 Jun 2022 08:30:59 -0400
X-MC-Unique: K4OhpCdxNkGGb0KdB6SrDw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3F50F811E81;
        Tue, 14 Jun 2022 12:30:58 +0000 (UTC)
Received: from fedora (unknown [10.22.9.132])
        by smtp.corp.redhat.com (Postfix) with SMTP id 0070B2166B26;
        Tue, 14 Jun 2022 12:30:54 +0000 (UTC)
Date:   Tue, 14 Jun 2022 09:30:52 -0300
From:   Wander Lairson Costa <wander@redhat.com>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kai Huang <kai.huang@intel.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 5/5] x86/tdx: Add Quote generation support
Message-ID: <Yqh/fCamrCoujZU5@fedora>
References: <20220609025220.2615197-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20220609025220.2615197-6-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220609025220.2615197-6-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 08, 2022 at 07:52:20PM -0700, Kuppuswamy Sathyanarayanan wrote:

[snip]

> +}
> +
> +/* Remove the shared mapping and free the memory */
> +static void deinit_quote_buf(struct quote_buf *buf)
> +{
> +	if (!buf)
> +		return;

nit: the null check isn't necessary anymore, is it?

[snip]

