Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91373C433EF
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Apr 2022 19:52:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239283AbiDHTyF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Apr 2022 15:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233000AbiDHTyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 15:54:01 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B7D1403F2
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 12:51:57 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 66so8614621pga.12
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 12:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+/pEd7g9sc537JcQUHMmtOGN8bVdoYIMIdp7gL4NXVE=;
        b=PeCCA4cXlctPtn0PwT8WPNO9iuN3Zx2eqNN7U28qU+csc6ly0jDQLJM9RWc2E2KVbJ
         AcUypMp0H+iw53GHXK5RvKZcP8/rkjWgfvdTjfeEnY9JIOitfRbYudZTS3OeAJfIKjxM
         uWwxNEXp7qaVn1XNTPUK6KRKStSZpigRp6RLbV/f7qCFJudh74rd+5+3/mBsCYKpDhQr
         b6MnEYR99I50+9xerR2G3OP8EPzSUpe/XS9ar0zUiH6TJmrdQO8VtaU0clsWQ4qTVfyQ
         Q7y9WQwRPVDbDiMvzFb+XVfc+9H/+wBfMYeWNQwluw8HVgoUp5aKu0AkxkABo0QFHfkt
         Lq0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+/pEd7g9sc537JcQUHMmtOGN8bVdoYIMIdp7gL4NXVE=;
        b=1/zHHFTVuaN8cM1R+pjeVS2GwzPaobgZDVKSJoILvStBwmv/vHNgn6/5nDcXOhweAj
         V1oFwJTGO+grI4buWRYjH94M3SzvKF8aqwd1ym4gZvG3EbekE7fvtJQNEmSFl+V/+Szv
         s0AgrJ+J3b1UZzGQge2o5ymmE6TP/Z9cyTM3PGz4jG7TQ/B6z7KdP8HDKhCiGNZM7pLq
         nuoDPlE2enfgQ6D/wIkSqTRd+Yy0Lz07gZ+WmhW6IdchT5QuQbJc5/65pTFZW6Z7HsdB
         Nd4UU7AZdilkt/k4TTXW3mpOMV3DiTeEQdUQ3Oc5TQ8/NdJGFFJE7gyUQ9zQPrCwT3qS
         5WmA==
X-Gm-Message-State: AOAM533k6xqCJATEA0NXRcL8YbJfZf77tCbgDlMfknDJuTM4lrDuCLFn
        Z8ZE/5r/fA4aMdvHfykq9wF5Sw==
X-Google-Smtp-Source: ABdhPJwPpu43BljXU9K8AZZjz8TjJeuS+SQLKh0qH/CIk0qQsuh7ASoLZtzI2XHsdurOpzw4rkCUUQ==
X-Received: by 2002:a63:4642:0:b0:398:b6b9:5f45 with SMTP id v2-20020a634642000000b00398b6b95f45mr17104239pgk.518.1649447516713;
        Fri, 08 Apr 2022 12:51:56 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id k13-20020aa7820d000000b004fa72a52040sm26955599pfi.172.2022.04.08.12.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 12:51:55 -0700 (PDT)
Date:   Fri, 8 Apr 2022 19:51:52 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Ben Gardon <bgardon@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        David Matlack <dmatlack@google.com>,
        Jim Mattson <jmattson@google.com>,
        David Dunn <daviddunn@google.com>,
        Jing Zhang <jingzhangos@google.com>,
        Junaid Shahid <junaids@google.com>
Subject: Re: [PATCH v3 02/11] KVM: selftests: Dump VM stats in binary stats
 test
Message-ID: <YlCSWH4pob00vZq3@google.com>
References: <20220330174621.1567317-1-bgardon@google.com>
 <20220330174621.1567317-3-bgardon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220330174621.1567317-3-bgardon@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 30, 2022, Ben Gardon wrote:
> Add kvm_util library functions to read KVM stats through the binary
> stats interface and then dump them to stdout when running the binary
> stats test. Subsequent commits will extend the kvm_util code and use it
> to make assertions in a test for NX hugepages.

Why?  Spamming my console with info that has zero meaning to me and is useless
when the test passes is not helpful.  Even on failure, I don't see what the user
is going to do with this information, all of the asserts are completly unrelated
to the stats themselves.
