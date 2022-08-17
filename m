Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD0A3C28B2B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Aug 2022 16:12:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240865AbiHQQMh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Aug 2022 12:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240752AbiHQQMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 12:12:16 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67A51A1A48
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 09:11:40 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id a22so11874873pfg.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 09:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=xWBAOz0eFV7zIDbajYRVEfhlshsoSDr9ZPkQQdAP7pc=;
        b=h7SljiIm/8xW6DLM4pfThX+2kjj5AwTCj9EbQfSLlIz0boS3dp8kEmHXrcrEDLTZjB
         fBsHWWSdYPF7EKp59OCi+F0zl/zrQbpuhEHH83c+pjd0N8aKYWLDmHvyzxTrw/ogOApS
         1PGz9H88SM82/R4sxNrK9xNLskSN8fJMKnYqefcCnveZO4Lx6ZmfZgqkTN3XV8lfwurp
         OW+X7Hti6PwPUX+QRg/E5FosMbDg3Ou4SxbF4e6aD91g9iWBlNbHWHfnwvw3EVA25eOn
         eqkJ5vGGzgC2PFJsT7C4dLYXG5mfDgAwwu50eQzqqjbwtMe4KmF9RfszNt4PbZ/T87oe
         5Rgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=xWBAOz0eFV7zIDbajYRVEfhlshsoSDr9ZPkQQdAP7pc=;
        b=bzqOz6+Hy89oiiGDsNg66Ndrt4dB0R/9xpxlp9dFpTAg5yVxeit6W+t39etaPGhwbU
         LOeHJgPoPjAZIptvkSCsoXBx1ZQGiZe8sJEbMGk+60Lz2tVlkB8MtLEKHGVXz4ko4aL3
         yam7vAu50tEcndRHcTcun+S/OgCmK1gr1C7JOq2Jgc/gji1jvdXGDevNDZLx6g1b3qzU
         i0Rj7FZiIigwwYxevaTlAAk180hCVNa7jllzrxJ+YjQHrsVAItxTpvU6E1SlK33Uz2qQ
         s/zJxwGWrthjei6ku5NsSAs21mVB+Cl7TDRinwCT726RCoozBMfe+i6mmlcROu93pdC+
         xB9A==
X-Gm-Message-State: ACgBeo0RXe9fqTke3gVF7owMLGgUZDZyZmwN56yQy3DFV4EOVUZUYONd
        fh4F3jHD+bZmH+DRb9SJ3SXhng==
X-Google-Smtp-Source: AA6agR6oKTRDycnGMDNJZWbSnb/UMGWAjGjto2V/nR4GLuW32gwG3tuh8tYjvi+yzQ0JHLyBsMDwwA==
X-Received: by 2002:a05:6a00:1996:b0:52e:b0f7:8c83 with SMTP id d22-20020a056a00199600b0052eb0f78c83mr26718408pfl.59.1660752699369;
        Wed, 17 Aug 2022 09:11:39 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id m19-20020a170902d19300b00172a4170ff5sm110004plb.86.2022.08.17.09.11.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 09:11:39 -0700 (PDT)
Date:   Wed, 17 Aug 2022 16:11:35 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc:     kvm@vger.kernel.org, pbonzini@redhat.com, tglx@linutronix.de,
        leobras@redhat.com, linux-kernel@vger.kernel.org, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org
Subject: Re: [PATCH] KVM: x86: Always enable legacy fp/sse
Message-ID: <Yv0TN0ZI0LNFMGQD@google.com>
References: <20220816175936.23238-1-dgilbert@redhat.com>
 <YvwODUu/rdzjzDjk@google.com>
 <YvzK+slWoAvm0/Wn@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YvzK+slWoAvm0/Wn@work-vm>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 17, 2022, Dr. David Alan Gilbert wrote:
> That passes the small smoke test for me; will you repost that then?

Yep, will do.
