Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83F0CC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 25 May 2022 15:04:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241789AbiEYPEb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 May 2022 11:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245145AbiEYPEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 11:04:14 -0400
Received: from relay3.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A35B1BA569
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 08:03:19 -0700 (PDT)
Received: from omf10.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay06.hostedemail.com (Postfix) with ESMTP id 6FF2235963;
        Wed, 25 May 2022 15:03:18 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf10.hostedemail.com (Postfix) with ESMTPA id 707AB39;
        Wed, 25 May 2022 15:03:17 +0000 (UTC)
Message-ID: <7a4641e036e4821b76eb4ed5b82a4f24b3029f05.camel@perches.com>
Subject: Re: checkpatch mistake on XA_STATE?
From:   Joe Perches <joe@perches.com>
To:     David Howells <dhowells@redhat.com>,
        Andy Whitcroft <apw@canonical.com>
Cc:     willy@infradead.org, linux-kernel@vger.kernel.org
Date:   Wed, 25 May 2022 08:03:16 -0700
In-Reply-To: <1962595.1653473587@warthog.procyon.org.uk>
References: <1962595.1653473587@warthog.procyon.org.uk>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Stat-Signature: jpq3cux4ucgb48uxrseiatkawh8x4k5d
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 707AB39
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18evceSDcCS8zC8x07XzapybqBJ010eLz4=
X-HE-Tag: 1653490997-366959
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-05-25 at 11:13 +0100, David Howells wrote:
> I see the following:
> 
> 	WARNING: Missing a blank line after declarations
> 	#1921: FILE: fs/cifs/smb2ops.c:4684:
> 	+       struct folio *folio;
> 	+       XA_STATE(xas, buffer, 0);
> 
> but XA_STATE() technically *is* a declaration.
> 
> Should checkpatch treat it as such?

Probably.
---
 scripts/checkpatch.pl | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 503e8abbb2c1e..2cf28014132f6 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1042,7 +1042,8 @@ our $FuncArg = qr{$Typecast{0,1}($LvalOrFunc|$Constant|$String)};
 our $declaration_macros = qr{(?x:
 	(?:$Storage\s+)?(?:[A-Z_][A-Z0-9]*_){0,2}(?:DEFINE|DECLARE)(?:_[A-Z0-9]+){1,6}\s*\(|
 	(?:$Storage\s+)?[HLP]?LIST_HEAD\s*\(|
-	(?:SKCIPHER_REQUEST|SHASH_DESC|AHASH_REQUEST)_ON_STACK\s*\(
+	(?:SKCIPHER_REQUEST|SHASH_DESC|AHASH_REQUEST)_ON_STACK\s*\(|
+	(?:$Storage\s+)?(?:XA_ARRAY|XA_ARRAY_ORDER)\s*\(
 )};
 
 our %allow_repeated_words = (


